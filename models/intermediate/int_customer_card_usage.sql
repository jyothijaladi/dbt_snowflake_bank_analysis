{{ config(materialized='incremental', unique_key='customer_card_usage_sk') }}

with cards as (
    select * from {{ ref('stg_cards') }}
),

card_txns as (
    select * from {{ ref('stg_card_transactions') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['c.customer_id', 'ct.card_txn_id']) }} as customer_card_usage_sk,
    c.customer_sk,
    ca.card_sk,
    ct.card_txn_sk,
    c.customer_id,
    ca.card_id,
    ct.card_txn_id,
    c.first_name,
    c.last_name,
    ct.amount,
    ct.currency,
    ct.merchant,
    ct.location,
    ct.transaction_time,
    ca.card_type,
    ca.card_status,
    ca.issued_date,
    ca.expired_date,
    ca.network,
    ca.features
from card_txns ct
join cards ca
    on ct.card_id = ca.card_id
join customers c
    on ca.customer_id = c.customer_id
