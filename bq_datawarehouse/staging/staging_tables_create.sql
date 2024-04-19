CREATE OR REPLACE TABLE `dtc-de-course-412605.dezoomcamp2024_capstone.stg_managers` AS
SELECT
  ROW_NUMBER() OVER () AS manager_id,
  first_name,
  last_name,
  TRIM(CONCAT(COALESCE(first_name, ''), ' ', COALESCE(last_name, ''))) as full_name,
  nationality,
  DATE(dob) as dob,
  team
FROM
  `dtc-de-course-412605.dezoomcamp2024_capstone.external_managers`;

CREATE OR REPLACE TABLE `dtc-de-course-412605.dezoomcamp2024_capstone.stg_goals` AS
SELECT
  *
FROM `dtc-de-course-412605.dezoomcamp2024_capstone.external_goals`;

CREATE OR REPLACE TABLE `dtc-de-course-412605.dezoomcamp2024_capstone.stg_matches` AS
SELECT
  match_id,
  season,
  PARSE_DATETIME('%d-%b-%y %I.%M.%E*S %p',date_time) AS date_time,
  home_team,
  away_team,
  stadium,
  home_team_score,
  away_team_score,
  penalty_shoot_out,
  attendance
FROM `dtc-de-course-412605.dezoomcamp2024_capstone.external_matches`;

CREATE OR REPLACE TABLE `dtc-de-course-412605.dezoomcamp2024_capstone.stg_players` AS
SELECT
  player_id,
  first_name,
  last_name,
  TRIM(CONCAT(COALESCE(first_name, ''), ' ', COALESCE(last_name, ''))) as full_name,
  nationality,
  DATE(dob) as dob,
  team,
  jersey_number,
  position,
  height,
  weight,
  foot
FROM `dtc-de-course-412605.dezoomcamp2024_capstone.external_players`;

CREATE OR REPLACE TABLE `dtc-de-course-412605.dezoomcamp2024_capstone.stg_stadiums` AS
SELECT
  ROW_NUMBER() OVER () AS stadium_id,
  *
FROM `dtc-de-course-412605.dezoomcamp2024_capstone.external_stadiums`;

CREATE OR REPLACE TABLE `dtc-de-course-412605.dezoomcamp2024_capstone.stg_teams` AS
SELECT
  ROW_NUMBER() OVER () AS team_id,
  *
FROM `dtc-de-course-412605.dezoomcamp2024_capstone.external_teams`;

