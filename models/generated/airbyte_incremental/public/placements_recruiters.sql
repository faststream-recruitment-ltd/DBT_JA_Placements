{{ config(
    indexes = [{'columns':['_airbyte_unique_key'],'unique':True}],
    unique_key = "_airbyte_unique_key",
    schema = "JobAdder",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('placements_recruiters_scd') }}
select
    _airbyte_unique_key,
    placementid,
    updatedat,
    userid,
    email,
    firstName,
    lastName,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_recruiters_hashid
from {{ ref('placements_recruiters_scd') }}
-- recruiters from {{ source('airbyte_internal', 'jobadder_destv2_raw__stream_placements') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_extracted_at', this) }}