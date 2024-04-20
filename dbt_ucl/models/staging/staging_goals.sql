{{ config(materialized="view") }}

with
    data as (
        select
            *
        from {{ source("staging", "stg_goals") }}
    )
select
    cast(goal_id as string) as goal_id,
    cast(match_id as string) as match_id,
    cast(pid as string) as pid,
    {{ dbt.safe_cast("duration", api.Column.translate_type("integer")) }} as duration,
    cast(assist as string) as assist,
    cast(goal_desc as string) as goal_desc
from data

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var("is_test_run", default=true) %} limit 100 {% endif %}