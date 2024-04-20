-- "team_name": str,
-- "country": str,
-- "home_stadium": str
{{ config(materialized="table") }}

with
    teams as (select * from {{ ref("staging_teams") }}),
    countries as (select * from {{ ref("dim_countries") }}),
    stadiums as (select * from {{ ref("dim_stadiums") }})
select t.team_id, t.team_name, c.country_id, s.stadium_id
from teams t
join countries c on t.country = c.country_name
join stadiums s on s.name = t.home_stadium
