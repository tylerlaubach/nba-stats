WITH ranked AS (
    SELECT * FROM {{ ref('int_team_season_rankings') }}
)

SELECT
    season_year,
    ROUND(MAX(CASE WHEN off_rank = 10 THEN avg_off_rating END)::NUMERIC, 1) AS off_rating_top10,
    ROUND(AVG(avg_off_rating)::NUMERIC, 1) AS off_rating_avg,
    ROUND(MAX(CASE WHEN off_rank = 21 THEN avg_off_rating END)::NUMERIC, 1) AS off_rating_bottom10,
    ROUND(MAX(CASE WHEN def_rank = 10 THEN avg_def_rating END)::NUMERIC, 1) AS def_rating_top10,
    ROUND(AVG(avg_def_rating)::NUMERIC, 1) AS def_rating_avg,
    ROUND(MAX(CASE WHEN def_rank = 21 THEN avg_def_rating END)::NUMERIC, 1) AS def_rating_bottom10
FROM ranked
GROUP BY 1