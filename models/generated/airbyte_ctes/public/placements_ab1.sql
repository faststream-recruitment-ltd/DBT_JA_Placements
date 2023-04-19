{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_placements') }}
select
    {{ json_extract_scalar('_airbyte_data', ['placementId'], ['placementId']) }} as placementid,
    {{ json_extract_scalar('_airbyte_data', ['endDate'], ['endDate']) }} as enddate,
    {{ json_extract_scalar('_airbyte_data', ['jobTitle'], ['jobTitle']) }} as jobtitle,
    {{ json_extract('table_alias', '_airbyte_data', ['source'], ['source']) }} as {{ adapter.quote('source') }},
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract('table_alias', '_airbyte_data', ['salary'], ['salary']) }} as salary,
    {{ json_extract('table_alias', '_airbyte_data', ['billing'], ['billing']) }} as billing,
    {{ json_extract_scalar('_airbyte_data', ['paymentType'], ['paymentType']) }} as paymenttype,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['approved'], ['approved']) }} as approved,
    {{ json_extract('table_alias', '_airbyte_data', ['candidate'], ['candidate']) }} as candidate,
    {{ json_extract('table_alias', '_airbyte_data', ['contact'], ['contact']) }} as contact,
    {{ json_extract_scalar('_airbyte_data', ['feeSplit'], ['feeSplit']) }} as feesplit,
    {{ json_extract('table_alias', '_airbyte_data', ['links'], ['links']) }} as links,
    {{ json_extract('table_alias', '_airbyte_data', ['company'], ['company']) }} as company,
    {{ json_extract_array('_airbyte_data', ['recruiters'], ['recruiters']) }} as recruiters,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract('table_alias', '_airbyte_data', ['owner'], ['owner']) }} as {{ adapter.quote('owner') }},
    {{ json_extract('table_alias', '_airbyte_data', ['workShift'], ['workShift']) }} as workshift,
    {{ json_extract('table_alias', '_airbyte_data', ['workplaceAddress'], ['workplaceAddress']) }} as workplaceaddress,
    {{ json_extract('table_alias', '_airbyte_data', ['updatedBy'], ['updatedBy']) }} as updatedby,
    {{ json_extract_array('_airbyte_data', ['custom'], ['custom']) }} as custom,
    {{ json_extract_scalar('_airbyte_data', ['approvedAt'], ['approvedAt']) }} as approvedat,
    {{ json_extract('table_alias', '_airbyte_data', ['createdBy'], ['createdBy']) }} as createdby,
    {{ json_extract('table_alias', '_airbyte_data', ['contractRate'], ['contractRate']) }} as contractrate,
    {{ json_extract('table_alias', '_airbyte_data', ['job'], ['job']) }} as job,
    {{ json_extract_scalar('_airbyte_data', ['chargeCurrency'], ['chargeCurrency']) }} as chargecurrency,
    {{ json_extract_scalar('_airbyte_data', ['startDate'], ['startDate']) }} as startdate,
    {{ json_extract('table_alias', '_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_placements') }} as table_alias
-- placements
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

