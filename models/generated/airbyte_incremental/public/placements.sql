{{ config(
    indexes = [{'columns':['_airbyte_unique_key'],'unique':True}],
    unique_key = "_airbyte_unique_key",
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('placements_scd') }}
select
    _airbyte_unique_key,
    placementid,
    enddate,
    jobtitle,
    {{ adapter.quote('source') }},
    {{ adapter.quote('type') }},
    salary,
    billing,
    paymenttype,
    createdat,
    approved,
    candidate,
    contact,
    feesplit,
    links,
    company,
    recruiters,
    updatedat,
    {{ adapter.quote('owner') }},
    workshift,
    workplaceaddress,
    updatedby,
    custom,
    approvedat,
    createdby,
    contractrate,
    job,
    chargecurrency,
    startdate,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_placements_hashid
from {{ ref('placements_scd') }}
-- placements from {{ source('public', '_airbyte_raw_placements') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

