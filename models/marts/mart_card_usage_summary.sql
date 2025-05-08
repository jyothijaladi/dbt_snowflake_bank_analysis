-- models/marts/mart_card_usage_summary.sql

{{ config(materialized='table') }}

SELECT
    icu.customer_sk,
    icu.customer_id,
    icu.first_name,
    icu.last_name,
    icu.card_id,
    icu.card_type,
    icu.card_status,
    icu.network,
    icu.features,
    {{ format_date("icu.transaction_time") }} AS card_txn_day,
    COUNT(*) AS total_card_transactions,
    SUM(icu.amount) AS total_card_spent,
    COUNT(DISTINCT icu.merchant) AS unique_merchants
FROM {{ ref('int_customer_card_usage') }} icu
GROUP BY
    icu.customer_sk,
    icu.customer_id,
    icu.first_name,
    icu.last_name,
    icu.card_id,
    icu.card_type,
    icu.card_status,
    icu.network,
    icu.features,
    card_txn_day
