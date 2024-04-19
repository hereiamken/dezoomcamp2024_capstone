{{ config(materialized="table") }}

with
    teams as (
        select country from {{ref("staging_teams")}}
    ),
    stadiums as (
        select country from {{ref("staging_stadiums")}}
    ),
    players as (
        select nationality from {{ref("staging_players")}}
    ),
    managers as (
        select nationality from {{ref("staging_managers")}}
    )
select
    