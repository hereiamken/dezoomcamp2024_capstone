{{ config(materialized="table") }}

with
    teams as (select country from {{ ref("staging_teams") }}),
    stadiums as (select country from {{ ref("staging_stadiums") }}),
    players as (select nationality as country from {{ ref("staging_players") }}),
    managers as (select nationality as country from {{ ref("staging_managers") }}),
    countries_unioned as (
        select *
        from teams
        union all
        select *
        from stadiums
        union all
        select *
        from players
        union all
        select *
        from managers
    ),
    countries as (
        select DISTINCT country
        from countries_unioned
    )
select row_number() over () as country_id, country as country_name
from countries
