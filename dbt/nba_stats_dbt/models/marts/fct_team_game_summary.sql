WITH gamelog AS (
SELECT * FROM {{ ref('stg_gamelog') }}
)

,boxscore AS (
SELECT * FROM {{ ref('stg_boxscore_advanced_team') }}
)

,league_aggregates AS (
SELECT * FROM {{ ref('int_league_aggregates') }}
)

SELECT
    gamelog.*,
    RIGHT(gamelog.matchup, LENGTH(gamelog.matchup) - 4) AS matchup_opp,
    CONCAT(CAST(gamelog.game_date AS TEXT), ' ', RIGHT(gamelog.matchup, LENGTH(gamelog.matchup) - 4)) AS date_opp,
    boxscore.off_rating,
    boxscore.def_rating,
    boxscore.net_rating,
    league_aggregates.off_rating_top10,
    league_aggregates.off_rating_avg,
    league_aggregates.off_rating_bottom10,
    league_aggregates.def_rating_top10,
    league_aggregates.def_rating_avg,
    league_aggregates.def_rating_bottom10,
    ROW_NUMBER() OVER (PARTITION BY gamelog.team_id, gamelog.season_year ORDER BY gamelog.game_date DESC) AS game_num_desc
FROM gamelog
INNER JOIN boxscore ON
    gamelog.game_id = boxscore.game_id
    AND gamelog.team_id = boxscore.team_id
LEFT JOIN league_aggregates ON gamelog.season_year = league_aggregates.season_year