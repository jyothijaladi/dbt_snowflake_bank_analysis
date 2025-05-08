{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'accounts') }}
),

cleaned as (
    select
        account_id,
        customer_id,
        lower(account_type) as account_type,
        coalesce(balance, 0.0) as balance,
        lower(status) as status,
        opened_date,
        closed_date
    from source
),

joined_types as (
    select
        a.*,
        t.description as account_type_description
    from cleaned a
    left join {{ ref('account_types') }} t
        on a.account_type = t.account_type
)

select
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_sk,
    *
from joined_types
