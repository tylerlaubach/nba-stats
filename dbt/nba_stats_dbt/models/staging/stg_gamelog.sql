SELECT
    game_id,
    team_id,
    team_name,
    game_date,
    matchup,
    season_year
FROM {{ source('nba_stats', 'gamelog') }}