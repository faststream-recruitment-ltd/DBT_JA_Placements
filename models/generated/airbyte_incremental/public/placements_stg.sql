{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('placements_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'placementid',
        'enddate',
        'jobtitle',
        object_to_string(adapter.quote('source')),
        adapter.quote('type'),
        object_to_string('salary'),
        object_to_string('billing'),
        'paymenttype',
        'createdat',
        boolean_to_string('approved'),
        object_to_string('candidate'),
        object_to_string('contact'),
        'feesplit',
        object_to_string('links'),
        object_to_string('company'),
        array_to_string('recruiters'),
        'updatedat',
        object_to_string(adapter.quote('owner')),
        object_to_string('workshift'),
        object_to_string('workplaceaddress'),
        object_to_string('updatedby'),
        array_to_string('custom'),
        'approvedat',
        object_to_string('createdby'),
        object_to_string('contractrate'),
        object_to_string('job'),
        'chargecurrency',
        'startdate',
        object_to_string('status'),
    ]) }} as _airbyte_placements_hashid,
    tmp.*
from {{ ref('placements_ab2') }} tmp
-- placements
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

