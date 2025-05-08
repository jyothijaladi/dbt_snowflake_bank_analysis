{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'transactions') }}
),

cleaned as (
    select
        transaction_id,
        account_id,
        lower(transaction_type) as transaction_type,
        amount,
        upper(currency) as currency,
        transaction_time,
        initcap(location) as location,
        initcap(merchant) as merchant
    from source
),

joined_types as (
    select
        t.*,
        tt.category as transaction_category
    from cleaned t
    left join {{ ref('transaction_types') }} tt
        on t.transaction_type = tt.transaction_type
)

select
    {{ dbt_utils.generate_surrogate_key(['transaction_id']) }} as transaction_sk,
    *
from joined_types
