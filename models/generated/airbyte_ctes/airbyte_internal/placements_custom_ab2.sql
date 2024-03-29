{{ config(
    indexes = [{'columns':['_airbyte_extracted_at'],'type':'btree'}],
    unique_key = '_airbyte_raw_id',
    schema = "_airbyte_internal",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('placements_custom_ab1') }}
select
    placementid,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    {{ adapter.quote('value') }},
    cast(fieldid as {{ dbt_utils.type_bigint() }}) as fieldid,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('placements_custom_ab1') }}
-- custom at placements/custom
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at', this) }}
