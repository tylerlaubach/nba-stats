import os
import sys
import time
import logging
import argparse
from typing import Dict
import pandas as pd
import psycopg2
import psycopg2.extras
from pathlib import Path
from nba_api.stats.endpoints import teamgamelogs, boxscoreadvancedv3
from config.column_maps import gamelog_cols_map, team_cols_map, player_cols_map

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

POSTGRES_HOST = os.getenv('POSTGRES_HOST', 'postgres')
POSTGRES_DB = os.getenv('POSTGRES_DB', 'airflow')
POSTGRES_USER = os.getenv('POSTGRES_USER', 'airflow')
POSTGRES_PASSWORD = os.getenv('POSTGRES_PASSWORD', 'airflow')


def get_existing_game_ids(conn) -> set:
    cur = conn.cursor()
    try:
        cur.execute("""
                    SELECT DISTINCT team.game_id
                    FROM nba_stats.boxscore_advanced_team AS team
                    INNER JOIN nba_stats.boxscore_advanced_player AS player ON team.game_id = player.game_id

        """)
        return {row[0] for row in cur.fetchall()}
    except Exception as e:
        logging.error(f"Error fetching existing game_ids: {e}")
        raise
    finally:
        cur.close()


def fetch_team_game_logs(season: str, season_type: str, existing_game_ids: set, raw_data_path: Path, resume: bool) -> tuple[pd.DataFrame, list[str]]:
    gamelog_fp = raw_data_path / 'team_gamelogs.parquet'

    if resume and gamelog_fp.exists():
        logging.info("Resuming from disk for TeamGameLogs")
        gamelog_df = pd.read_parquet(gamelog_fp)
    else:
        logging.info("Fetching TeamGameLogs...")
        gamelog_df = (
            teamgamelogs
            .TeamGameLogs(season_nullable=season, season_type_nullable=season_type)
            .get_data_frames()[0]
        )
        gamelog_df.to_parquet(gamelog_fp, index=False)

    new_game_ids = [game_id for game_id in gamelog_df['GAME_ID'].unique() if game_id not in existing_game_ids]
    return gamelog_df, new_game_ids


def fetch_boxscore_advanced(game_ids: list[str], raw_data_path: Path, resume: bool) -> tuple[pd.DataFrame, pd.DataFrame]:
    team_fp = raw_data_path / 'boxscore_team.parquet'
    player_fp = raw_data_path / 'boxscore_player.parquet'

    if resume and team_fp.exists() and player_fp.exists():
        logging.info("Resuming boxscore data from disk")
        return pd.read_parquet(team_fp), pd.read_parquet(player_fp)

    team_dfs = []
    player_dfs = []

    for game_id in game_ids:
        try:
            logging.info(f"Fetching BoxScoreAdvancedV3 for game {game_id}")
            boxscore = boxscoreadvancedv3.BoxScoreAdvancedV3(game_id=game_id).get_data_frames()
            player_dfs.append(boxscore[0])
            team_dfs.append(boxscore[1])
            time.sleep(1)
        except Exception as e:
            logging.warning(f"Failed to fetch boxscore for game {game_id}: {e}")

    team_df = pd.concat(team_dfs) if team_dfs else pd.DataFrame()
    player_df = pd.concat(player_dfs) if player_dfs else pd.DataFrame()

    team_df.to_parquet(team_fp, index=False)
    player_df.to_parquet(player_fp, index=False)
    return team_df, player_df


def transform_data(df: pd.DataFrame, cols_map: Dict[str, str]) -> pd.DataFrame:
    return df[[col for col in df.columns if col in cols_map]].rename(columns=cols_map)


def load_to_postgres(conn, df: pd.DataFrame, target_table: str, conflict_keys: list[str]) -> None:
    if df.empty:
        return

    cur = conn.cursor()
    temp_table = "temp_merge_staging"
    columns = list(df.columns)
    columns_str = ', '.join(columns)
    update_cols = [col for col in columns if col not in conflict_keys]

    cur.execute(f"DROP TABLE IF EXISTS {temp_table}")
    cur.execute(f"CREATE TEMP TABLE {temp_table} (LIKE {target_table} INCLUDING ALL)")

    psycopg2.extras.execute_batch(
        cur,
        f"INSERT INTO {temp_table} ({columns_str}) VALUES ({', '.join(['%s'] * len(columns))})",
        df.values.tolist(),
        page_size=1000
    )

    conflict_condition = ' AND '.join([f"T.{k} = S.{k}" for k in conflict_keys])
    update_str = ', '.join([f"{col} = S.{col}" for col in update_cols])
    insert_values = ', '.join([f"S.{col}" for col in columns])

    merge_sql = f"""
        MERGE INTO {target_table} AS T
        USING {temp_table} AS S
        ON {conflict_condition}
        WHEN MATCHED THEN
            UPDATE SET {update_str}
        WHEN NOT MATCHED THEN
            INSERT ({columns_str}) VALUES ({insert_values});
    """
    cur.execute(merge_sql)
    logging.info(f"MERGE complete into {target_table}, rows: {len(df)}")
    cur.close()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--season', default='2024-25')
    parser.add_argument('--season_type', default='Regular Season')
    parser.add_argument('--resume', action='store_true')
    args = parser.parse_args()

    raw_data_path = Path("data/raw") / args.season.replace("/", "-")
    raw_data_path.mkdir(parents=True, exist_ok=True)

    conn = psycopg2.connect(
        host=POSTGRES_HOST,
        dbname=POSTGRES_DB,
        user=POSTGRES_USER,
        password=POSTGRES_PASSWORD
    )
    existing_ids = get_existing_game_ids(conn)

    gamelog_df, new_game_ids = fetch_team_game_logs(args.season, args.season_type, existing_ids, raw_data_path, args.resume)
    if gamelog_df.empty:
        logging.warning("No gamelog data fetched.")
        return

    team_df, player_df = fetch_boxscore_advanced(new_game_ids, raw_data_path, args.resume)

    try:
        gamelog_df = transform_data(gamelog_df, gamelog_cols_map)
        team_df = transform_data(team_df, team_cols_map)
        player_df = transform_data(player_df, player_cols_map)

        with conn:
            load_to_postgres(conn, gamelog_df, 'nba_stats.gamelog', ['team_id', 'game_id'])
            load_to_postgres(conn, team_df, 'nba_stats.boxscore_advanced_team', ['game_id', 'team_id'])
            load_to_postgres(conn, player_df, 'nba_stats.boxscore_advanced_player', ['game_id', 'person_id'])
    except Exception as e:
        logging.error(f"Failed to transform/load data: {e}")
    finally:
        conn.close()


if __name__ == '__main__':
    main()
