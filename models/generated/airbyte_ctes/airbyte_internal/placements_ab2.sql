{{ config(
    indexes = [{'columns':['_airbyte_extracted_at'],'type':'btree'}],
    unique_key = '_airbyte_raw_id',
    schema = "_airbyte_internal",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('placements_ab1') }}
select
    placementid,
    cast(job_jobId as {{ dbt_utils.type_string() }}) as job_jobId,
    cast(job_source as {{ dbt_utils.type_string() }}) as job_source,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(owner_email as {{ dbt_utils.type_string() }}) as owner_email,
    cast(owner_userId as {{ dbt_utils.type_string() }}) as owner_userId,
    cast(owner_lastName as {{ dbt_utils.type_string() }}) as owner_lastName,
    cast(owner_firstName as {{ dbt_utils.type_string() }}) as owner_firstName,
    cast(salary_fee as {{ dbt_utils.type_string() }}) as salary_fee,
    cast(salary_base as {{ dbt_utils.type_string() }}) as salary_base,
    cast(salary_total as {{ dbt_utils.type_string() }}) as salary_total,
    cast(status_name as {{ dbt_utils.type_string() }}) as status_name,
    cast(status_statusId as {{ dbt_utils.type_string() }}) as status_statusId,
    cast(company_companyId as {{ dbt_utils.type_string() }}) as company_companyId,
    cast(company_name as {{ dbt_utils.type_string() }}) as company_name,
    contact_email,
    cast(contact_lastName as {{ dbt_utils.type_string() }}) as contact_lastName,
    cast(contact_contactId as {{ dbt_utils.type_string() }}) as contact_contactId,
    cast(contact_firstName as {{ dbt_utils.type_string() }}) as contact_firstName,
    cast(jobTitle as {{ dbt_utils.type_string() }}) as jobTitle,
    cast(candidate_email as {{ dbt_utils.type_string() }}) as candidate_email,
    cast(candidate_candidateId as {{ dbt_utils.type_string() }}) as candidate_candidateId,
    cast(candidate_lastName as {{ dbt_utils.type_string() }}) as candidate_lastName,
    cast(candidate_firstName as {{ dbt_utils.type_string() }}) as candidate_firstName,
    cast(candidate_source as {{ dbt_utils.type_string() }}) as candidate_source,
    cast(createdAt as {{ dbt_utils.type_string() }}) as createdAt,
    cast(startDate as {{ dbt_utils.type_string() }}) as startDate,
    cast(updatedAt as {{ dbt_utils.type_string() }}) as updatedAt,
    recruiters,
    cast(chargeCurrency as {{ dbt_utils.type_string() }}) as chargeCurrency,
    cast(workplaceAddress_url as {{ dbt_utils.type_string() }}) as workplaceAddress_url,
    cast(workplaceAddress_city as {{ dbt_utils.type_string() }}) as workplaceAddress_city,
    cast(workplaceAddress_name as {{ dbt_utils.type_string() }}) as workplaceAddress_name,
    cast(workplaceAddress_street as {{ dbt_utils.type_string() }}) as workplaceAddress_street,
    cast(workplaceAddress_country as {{ dbt_utils.type_string() }}) as workplaceAddress_country,
    cast(workplaceAddress_postcode as {{ dbt_utils.type_string() }}) as workplaceAddress_postcode,
    cast(workplaceAddress_postalCode as {{ dbt_utils.type_string() }}) as workplaceAddress_postalCode,
    custom,
    cast(updatedBy_email as {{ dbt_utils.type_string() }}) as updatedBy_email,
    cast(updatedBy_userId as {{ dbt_utils.type_string() }}) as updatedBy_userId,
    cast(updatedBy_lastName as {{ dbt_utils.type_string() }}) as updatedBy_lastName,
    cast(updatedBy_firstName as {{ dbt_utils.type_string() }}) as updatedBy_firstName,
    cast(paymentType as {{ dbt_utils.type_string() }}) as paymentType,
    cast(billing_email as {{ dbt_utils.type_string() }}) as billing_email,
    cast(billing_terms as {{ dbt_utils.type_string() }}) as billing_terms,
    cast(billing_dueDate as {{ dbt_utils.type_string() }}) as billing_dueDate,
    cast(feeSplit as {{ dbt_utils.type_string() }}) as feeSplit,
    cast(createdBy_email as {{ dbt_utils.type_string() }}) as createdBy_email,
    cast(createdBy_userId as {{ dbt_utils.type_string() }}) as createdBy_userId,
    cast(createdBy_lastName as {{ dbt_utils.type_string() }}) as createdBy_lastName,
    cast(createdBy_firstName as {{ dbt_utils.type_string() }}) as createdBy_firstName,
    cast(contractRate_onCosts as {{ dbt_utils.type_string() }}) as contractRate_onCosts,
    cast(contractRate_ratePer as {{ dbt_utils.type_string() }}) as contractRate_ratePer,
    cast(contractRate_onCostsType as {{ dbt_utils.type_string() }}) as contractRate_onCostsType,
    cast(contractRate_candidateRate as {{ dbt_utils.type_string() }}) as contractRate_candidateRate,
    cast(summary as {{ dbt_utils.type_string() }}) as summary,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('placements_ab1') }}
-- placements
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at', this) }}