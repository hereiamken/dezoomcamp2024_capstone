{{ config(materialized="view") }}

with
    data as (
        select
            *
        from {{ source("staging", "stg_teams") }}
    )
select
    {{ dbt.safe_cast("team_id", api.Column.translate_type("integer")) }} as team_id,
    cast(team_name as string) as team_name,
    cast(country as string) as country,
    cast(home_stadium as string) as home_stadium
from data

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var("is_test_run", default=true) %} limit 100 {% endif %}