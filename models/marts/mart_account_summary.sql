-- models/marts/mart_account_summary.sql

{{ config(materialized='table') }}

SELECT
    ica.customer_sk,
    ica.customer_id,
    ica.first_name,
    ica.last_name,
    ica.email,
    ica.country_name,
    ica.region,
    ica.account_id,
    ica.account_type,
    ica.account_type_description,
    ica.account_status,
    {{ format_date("ica.opened_date") }} AS account_open_date,
    {{ format_date("ica.closed_date") }} AS account_close_date,
    ica.balance
FROM {{ ref('int_customer_accounts') }} ica
