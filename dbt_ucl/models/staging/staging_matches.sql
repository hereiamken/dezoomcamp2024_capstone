{{ config(materialized="view") }}

with
    data as (
        select
            *
        from {{ source("staging", "stg_matches_partitoned_clustered") }}
    )
select
    cast(match_id as string) as match_id,
    cast(season as string) as season,
    date_time as date_time,
    cast(home_team as string) as home_team,
    cast(away_team as string) as away_team,
    cast(stadium as string) as stadium,
    {{ dbt.safe_cast("home_team_score", api.Column.translate_type("integer")) }} as home_team_score,
    {{ dbt.safe_cast("away_team_score", api.Column.translate_type("integer")) }} as away_team_score,
    {{ dbt.safe_cast("penalty_shoot_out", api.Column.translate_type("integer")) }} as penalty_shoot_out,
    {{ dbt.safe_cast("attendance", api.Column.translate_type("integer")) }} as attendance
from data

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var("is_test_run", default=true) %} limit 100 {% endif %}