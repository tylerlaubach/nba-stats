SELECT
    game_id,
    team_id,
    team_city,
    team_name,
    team_tricode,
    off_rating,
    def_rating,
    net_rating,
    ast_pct,
    ast_to_ratio,
    oreb_pct,
    dreb_pct,
    efg_pct,
    ts_pct,
    pace,
    possessions
FROM {{ source('nba_stats', 'boxscore_advanced_team') }}