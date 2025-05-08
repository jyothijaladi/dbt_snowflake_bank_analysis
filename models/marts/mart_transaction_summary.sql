-- models/marts/mart_transaction_summary.sql

{{ config(materialized='table') }}

SELECT
    ica.customer_sk,
    ica.customer_id,
    ica.first_name,
    ica.last_name,
    ica.country_name,
    ita.transaction_type,
    ita.transaction_category,
    {{ format_date("ita.transaction_time") }} AS transaction_day,
    COUNT(*) AS total_transactions,
    SUM(ita.amount) AS total_amount
FROM {{ ref('int_account_transactions') }} ita
JOIN {{ ref('int_customer_accounts') }} ica
  ON ita.account_id = ica.account_id
GROUP BY
    ica.customer_sk,
    ica.customer_id,
    ica.first_name,
    ica.last_name,
    ica.country_name,
    ita.transaction_type,
    ita.transaction_category,
    transaction_day
