{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'card_transactions') }}
),

cleaned as (
    select
        card_txn_id,
        card_id,
        transaction_time,
        initcap(merchant) as merchant,
        amount,
        initcap(location) as location,
        upper(currency) as currency
    from source
)

select
    {{ dbt_utils.generate_surrogate_key(['card_txn_id']) }} as card_txn_sk,
    *
from cleaned
