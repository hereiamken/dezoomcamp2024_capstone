{{ config(materialized="table") }}

with
    stadiums as (select * from {{ ref("staging_stadiums") }}),
    cities as (select * from {{ ref("dim_cities") }}),
    countries as (select * from {{ ref("dim_countries") }})
select stadium_id, name, ci.city_id as city_id, co.country_id as country_id, capacity
from stadiums st
join cities ci on ci.city_name = st.city
join countries co on co.country_name = st.country
