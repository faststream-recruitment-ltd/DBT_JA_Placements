{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('placements_ab1') }}
select
    cast(placementid as {{ dbt_utils.type_bigint() }}) as placementid,
    cast(enddate as {{ dbt_utils.type_string() }}) as enddate,
    cast(jobtitle as {{ dbt_utils.type_string() }}) as jobtitle,
    cast({{ adapter.quote('source') }} as {{ type_json() }}) as {{ adapter.quote('source') }},
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast(salary as {{ type_json() }}) as salary,
    cast(billing as {{ type_json() }}) as billing,
    cast(paymenttype as {{ dbt_utils.type_string() }}) as paymenttype,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    {{ cast_to_boolean('approved') }} as approved,
    cast(candidate as {{ type_json() }}) as candidate,
    cast(contact as {{ type_json() }}) as contact,
    cast(feesplit as {{ dbt_utils.type_string() }}) as feesplit,
    cast(links as {{ type_json() }}) as links,
    cast(company as {{ type_json() }}) as company,
    recruiters,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast({{ adapter.quote('owner') }} as {{ type_json() }}) as {{ adapter.quote('owner') }},
    cast(workshift as {{ type_json() }}) as workshift,
    cast(workplaceaddress as {{ type_json() }}) as workplaceaddress,
    cast(updatedby as {{ type_json() }}) as updatedby,
    custom,
    cast(approvedat as {{ dbt_utils.type_string() }}) as approvedat,
    cast(createdby as {{ type_json() }}) as createdby,
    cast(contractrate as {{ type_json() }}) as contractrate,
    cast(job as {{ type_json() }}) as job,
    cast(chargecurrency as {{ dbt_utils.type_string() }}) as chargecurrency,
    cast(startdate as {{ dbt_utils.type_string() }}) as startdate,
    cast(status as {{ type_json() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('placements_ab1') }}
-- placements
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

