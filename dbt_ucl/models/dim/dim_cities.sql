{{ config(materialized="table") }}

with
    stadiums as (select city, country from {{ ref("staging_stadiums") }}),
    cities as (select distinct city, country from stadiums),
    countries as (select * from {{ ref("dim_countries") }})
select row_number() over () as city_id, city as city_name, co.country_id
from cities ci
join countries co on ci.country = co.country_name
