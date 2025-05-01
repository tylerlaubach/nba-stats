import os
import time
import logging
from typing import Dict
import pandas as pd
import psycopg2
import psycopg2.extras
from nba_api.stats.static import teams
from nba_api.stats.endpoints import boxscoreadvancedv3
from nba_api.stats.endpoints import teamgamelog

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Constants
TEAM = '76ers'
SEASON = '2024-25'
SEASON_TYPE = 'Regular Season'

POSTGRES_HOST = os.getenv('POSTGRES_HOST', 'postgres')
POSTGRES_DB = os.getenv('POSTGRES_DB', 'airflow')
POSTGRES_USER = os.getenv('POSTGRES_USER', 'airflow')
POSTGRES_PASSWORD = os.getenv('POSTGRES_PASSWORD', 'airflow')
POSTGRES_TABLE = os.getenv('POSTGRES_TABLE', 'sixers_boxscore_advanced')

def get_existing_game_ids(conn, table_name: str) -> set:
    cur = conn.cursor()
    try:
        cur.execute(f"SELECT DISTINCT game_id FROM {table_name}")
        return {row[0] for row in cur.fetchall()}
    except Exception as e:
        logging.error(f"Error fetching existing game_ids from {table_name}: {e}")
        raise Exception("couldn't fetch existing game IDs")
    finally:
        cur.close()


def get_team_id(team_name: str) -> str:
    nba_teams = teams.get_teams()
    return next(team['id'] for team in nba_teams if team['nickname'] == team_name)


def fetch_data(team_id: str, conn) -> tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
    gamelog = (
        teamgamelog
        .TeamGameLog(team_id=team_id, season=SEASON, season_type_all_star=SEASON_TYPE)
        .get_data_frames()[0]
    )

    existing_game_ids = get_existing_game_ids(conn, 'nba_stats.boxscore_advanced_team')

    team_dfs = []
    player_dfs = []

    for game_id in gamelog['Game_ID']:
        if game_id in existing_game_ids:
            logging.info(f'Skipping already fetched game ID {game_id}')
            continue

        logging.info(f'Fetching advanced boxscore for game ID {game_id}')
        advanced_boxscore = boxscoreadvancedv3.BoxScoreAdvancedV3(game_id=game_id).get_data_frames()
        team_df, player_df = advanced_boxscore[1], advanced_boxscore[0]
        team_dfs.append(team_df)
        player_dfs.append(player_df)

        time.sleep(1)

    if not team_dfs or not player_dfs:
        return pd.DataFrame(), pd.DataFrame(), pd.DataFrame()

    team_data = pd.concat(team_dfs, ignore_index=True)
    player_data = pd.concat(player_dfs, ignore_index=True)
    
    return gamelog, team_data, player_data

gamelog_cols_map = {
    'Team_ID': 'team_id',
    'Game_ID': 'game_id',
    'GAME_DATE': 'game_date',
    'MATCHUP': 'matchup',
    'WL': 'wl',
    'W': 'w',
    'L': 'l',
    'MIN': 'min',
    'FGM': 'fgm',
    'FGA': 'fga',
    'FG3M': 'fg3m',
    'FG3A': 'fg3a',
    'FTM': 'ftm',
    'FTA': 'fta',
    'OREB': 'oreb',
    'DREB': 'dreb',
    'AST': 'ast',
    'STL': 'stl',
    'BLK': 'blk',
    'TOV': 'tov',
    'PF': 'pf',
    'PTS': 'pts'
}

team_cols_map = {
    'gameId': 'game_id',
    'teamId': 'team_id',
    'teamCity': 'team_city',
    'teamName': 'team_name',
    'teamTricode': 'team_tricode',
    'offensiveRating': 'off_rating',
    'defensiveRating': 'def_rating',
    'netRating': 'net_rating',
    'assistPercentage': 'ast_pct',
    'assistToTurnover': 'ast_to_ratio',
    'offensiveReboundPercentage': 'oreb_pct',
    'defensiveReboundPercentage': 'dreb_pct',
    'effectiveFieldGoalPercentage': 'efg_pct',
    'trueShootingPercentage': 'ts_pct',
    'pace': 'pace',
    'possessions': 'possessions'
}

player_cols_map = {
    'gameId': 'game_id',
    'teamId': 'team_id',
    'teamCity': 'team_city',
    'teamName': 'team_name',
    'teamTricode': 'team_tricode',
    'personId': 'person_id',
    'firstName': 'first_name',
    'lastName': 'last_name',
    'position': 'position',
    'minutes': 'minutes',
    'offensiveRating': 'off_rating',
    'defensiveRating': 'def_rating',
    'netRating': 'net_rating',
    'assistPercentage': 'ast_pct',
    'assistToTurnover': 'ast_to_ratio',
    'offensiveReboundPercentage': 'oreb_pct',
    'defensiveReboundPercentage': 'dreb_pct',
    'effectiveFieldGoalPercentage': 'efg_pct',
    'trueShootingPercentage': 'ts_pct',
    'usagePercentage': 'usage_pct',
    'pace': 'pace',
    'possessions': 'possessions'
}

def transform_data(df: pd.DataFrame, cols_map: Dict[str, str]) -> pd.DataFrame:
    # Keep only necessary columns
    df = df[[col for col in df.columns if col in cols_map.keys()]]

    # Rename columns
    df = df.rename(columns=cols_map)

    return df

def load_to_postgres(conn, df: pd.DataFrame, target_table: str, conflict_keys: list[str]) -> None:
    if df.empty:
        logging.info(f'Dataframe is empty for {target_table}')
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
    logging.info('Starting fetch and load for advanced boxscore stats')

    conn = psycopg2.connect(
        host=POSTGRES_HOST,
        dbname=POSTGRES_DB,
        user=POSTGRES_USER,
        password=POSTGRES_PASSWORD
    )

    try:
        team_id = get_team_id(TEAM)
        gamelog_df, team_df, player_df = fetch_data(team_id, conn)

        if gamelog_df.empty or team_df.empty or player_df.empty:
            logging.warning('No new data to load.')
            return

        # Transform
        gamelog_df = transform_data(gamelog_df, gamelog_cols_map)
        team_df = transform_data(team_df, team_cols_map)
        player_df = transform_data(player_df, player_cols_map)

        # Begin transaction
        with conn:
            with conn.cursor() as cur:
                load_to_postgres(conn, gamelog_df, 'nba_stats.gamelog', ['team_id','game_id'])
                load_to_postgres(conn, team_df, 'nba_stats.boxscore_advanced_team', ['game_id', 'team_id'])
                load_to_postgres(conn, player_df, 'nba_stats.boxscore_advanced_player', ['game_id', 'person_id'])

        logging.info('Successfully loaded data')
    except Exception as e:
        logging.error(f"Error during fetch/load: {e}")
        conn.rollback()
    finally:
        conn.close()

if __name__ == '__main__':
    main()
