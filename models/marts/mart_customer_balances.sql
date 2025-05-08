-- models/marts/mart_customer_balances.sql

{{ config(materialized='table') }}

SELECT
    customer_sk,
    customer_id,
    first_name,
    last_name,
    email,
    country_name,
    region,
    COUNT(account_id) AS total_accounts,
    SUM(balance) AS total_balance,
    COUNT(CASE WHEN account_status = 'active' THEN 1 END) AS active_accounts,
    COUNT(CASE WHEN account_status = 'closed' THEN 1 END) AS closed_accounts,
    MIN({{ format_date("opened_date") }}) AS first_account_opened,
    MAX({{ format_date("opened_date") }}) AS last_account_opened
FROM {{ ref('int_customer_accounts') }}
GROUP BY
    customer_sk,
    customer_id,
    first_name,
    last_name,
    email,
    country_name,
    region
