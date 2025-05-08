{{ config(materialized='incremental', unique_key='customer_account_sk') }}

with customers as (
    select * from {{ ref('stg_customers') }}
),

accounts as (
    select * from {{ ref('stg_accounts') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['c.customer_id', 'a.account_id']) }} as customer_account_sk,
    c.customer_sk,
    a.account_sk,
    c.customer_id,
    a.account_id,
    c.first_name,
    c.last_name,
    c.email,
    a.account_type,
    a.account_type_description,
    a.balance,
    a.status as account_status,
    a.opened_date,
    a.closed_date,
    c.country,
    c.country_name,
    c.region,
    c.created_at as customer_created_at
from customers c
join accounts a
    on c.customer_id = a.customer_id
