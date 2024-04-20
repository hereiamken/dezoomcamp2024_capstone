{{ config(materialized="view") }}

with
    data as (
        select
            *
        from {{ source("staging", "stg_stadiums") }}
    )
select
    {{ dbt.safe_cast("stadium_id", api.Column.translate_type("integer")) }} as stadium_id,
    cast(name as string) as name,
    cast(city as string) as city,
    cast(country as string) as country,
    {{ dbt.safe_cast("capacity", api.Column.translate_type("integer")) }} as capacity
from data

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var("is_test_run", default=true) %} limit 100 {% endif %}