WITH boxscore AS (
    SELECT * FROM {{ ref('stg_boxscore_advanced_team') }}
)

,gamelog AS (
    SELECT * FROM {{ ref('stg_gamelog') }}
)

,team_averages AS (
SELECT
    gamelog.season_year,
    boxscore.team_id,
    AVG(boxscore.off_rating) AS avg_off_rating,
    AVG(boxscore.def_rating) AS avg_def_rating
FROM boxscore
INNER JOIN gamelog ON
    boxscore.game_id = gamelog.game_id
    AND boxscore.team_id = gamelog.team_id
GROUP BY 1,2
)

SELECT
    season_year
    ,team_id
    ,avg_off_rating
    ,avg_def_rating
    ,RANK() OVER (PARTITION BY season_year ORDER BY avg_off_rating DESC) AS off_rank
    ,RANK() OVER (PARTITION BY season_year ORDER BY avg_def_rating) AS def_rank
FROM team_averages