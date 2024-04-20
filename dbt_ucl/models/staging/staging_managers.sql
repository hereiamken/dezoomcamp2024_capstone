{{ config(materialized="view") }}

with
    data as (
        select
            *
        from {{ source("staging", "stg_managers") }}
    )
select
    cast(manager_id as string) as manager_id,
    cast(first_name as string) as first_name,
    cast(last_name as string) as last_name,
    cast(full_name as string) as full_name,
    cast(nationality as string) as nationality,
    dob as dob,
    cast(team as string) as team
from data

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var("is_test_run", default=true) %} limit 100 {% endif %}