{% snapshot account_snapshot %}
    {{
        config(
            target_schema='raw',
            unique_key='account_id',
            strategy='check',
            check_cols=['balance', 'status', 'opened_date', 'closed_date'],
            updated_at='updated_at'
        )
    }}

    select
        account_id,
        customer_id,
        account_type,
        balance,
        status,
        opened_date,
        closed_date,
        current_timestamp() as updated_at
    from {{ ref('stg_accounts') }}

{% endsnapshot %}
