{{ config(
    indexes = [{'columns':['_airbyte_extracted_at'],'type':'btree'}],
    unique_key = '_airbyte_raw_id',
    schema = "_airbyte_internal",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('airbyte_internal', 'jobadder_destv2_raw__stream_placements') }}
select
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['placementId'], ['placementId']) }} as placementid,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'recruiters'))->>'userId' as userid,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'recruiters'))->>'email' as email,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'recruiters'))->>'firstName' as firstName,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'recruiters'))->>'lastName' as lastName,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('airbyte_internal', 'jobadder_destv2_raw__stream_placements') }}  as table_alias
-- placement_recruiters
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at', this) }}