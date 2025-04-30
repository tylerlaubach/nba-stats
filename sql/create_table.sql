CREATE TABLE nba_stats.boxscore_advanced_team (
    game_id VARCHAR(32),
    team_id VARCHAR(32),
    team_city VARCHAR(32),
    team_name VARCHAR(32),
    team_tricode VARCHAR(32),
    off_rating FLOAT,
    def_rating FLOAT,
    net_rating FLOAT,
    ast_pct FLOAT,
    ast_to_ratio FLOAT,
    oreb_pct FLOAT,
    dreb_pct FLOAT,
    efg_pct FLOAT,
    ts_pct FLOAT,
    pace FLOAT,
    possessions FLOAT,
    PRIMARY KEY (game_id, team_id)
)
;

CREATE TABLE nba_stats.boxscore_advanced_player (
    game_id VARCHAR(32),
    team_id VARCHAR(32),
    team_city VARCHAR(32),
    team_name VARCHAR(32),
    team_tricode VARCHAR(32),
    person_id VARCHAR(32),
    first_name VARCHAR(32),
    last_name VARCHAR(32),
    position VARCHAR(32),
    minutes VARCHAR(32),
    off_rating FLOAT,
    def_rating FLOAT,
    net_rating FLOAT,
    ast_pct FLOAT,
    ast_to_ratio FLOAT,
    oreb_pct FLOAT,
    dreb_pct FLOAT,
    efg_pct FLOAT,
    ts_pct FLOAT,
    usage_pct FLOAT,
    pace FLOAT,
    possessions FLOAT,
    PRIMARY KEY (game_id, team_id)
)
;

CREATE TABLE nba_stats.gamelog (
    team_id VARCHAR(32),
    game_id VARCHAR(32),
    game_date DATE,
    matchup VARCHAR(32),
    wl VARCHAR(32),
    w INTEGER,
    l INTEGER,
    min INTEGER,
    fgm INTEGER,
    fga INTEGER,
    fg3m INTEGER,
    fg3a INTEGER,
    ftm INTEGER,
    fta INTEGER,
    oreb INTEGER,
    dreb INTEGER,
    ast INTEGER,
    stl INTEGER,
    blk INTEGER,
    tov INTEGER,
    pf INTEGER,
    pts INTEGER,
    PRIMARY KEY (team_id, game_id)
)
;
