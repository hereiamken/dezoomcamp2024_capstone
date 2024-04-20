{{ config(materialized="view") }}

with
    data as (
        select
            *
        from {{ source("staging", "stg_players") }}
    )
select
    cast(player_id as string) as player_id,
    cast(first_name as string) as first_name,
    cast(last_name as string) as last_name,
    cast(full_name as string) as full_name,
    cast(nationality as string) as nationality,
    dob as dob,
    cast(team as string) as team,
    {{ dbt.safe_cast("jersey_number", api.Column.translate_type("integer")) }} as jersey_number,
    cast(position as string) as position,
    {{ dbt.safe_cast("height", api.Column.translate_type("integer")) }} as height,
    {{ dbt.safe_cast("weight", api.Column.translate_type("integer")) }} as weight,
    cast(foot as string) as foot
from data

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var("is_test_run", default=true) %} limit 100 {% endif %}