{{ config(materialized='incremental', unique_key='account_transaction_sk') }}

with transactions as (
    select * from {{ ref('stg_transactions') }}
),

accounts as (
    select * from {{ ref('stg_accounts') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['a.account_id', 't.transaction_id']) }} as account_transaction_sk,
    a.account_sk,
    t.transaction_sk,
    a.account_id,
    t.transaction_id,
    a.customer_id,
    t.transaction_type,
    t.transaction_category,
    t.amount,
    t.currency,
    t.transaction_time,
    t.location,
    t.merchant,
    a.account_type,
    a.account_type_description,
    a.status as account_status,
    a.opened_date
from transactions t
join accounts a
    on t.account_id = a.account_id
