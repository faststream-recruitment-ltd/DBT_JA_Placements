{{ config(
    indexes = [{'columns':['_airbyte_extracted_at'],'type':'btree'}],
    unique_key = '_airbyte_raw_id',
    schema = "_airbyte_internal",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('airbyte_internal', 'jobadder_destv2_raw__stream_placements') }}
select
    {{ json_extract_scalar('_airbyte_data', ['placementId'], ['placementId']) }} as placementid,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'custom'))->>'name' as name,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'custom'))->>'type' as type,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'custom'))->>'value' as value,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'custom'))->>'fieldId' as fieldId,    
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('airbyte_internal', 'jobadder_destv2_raw__stream_placements') }} as table_alias
-- placement_custom
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at', this) }}