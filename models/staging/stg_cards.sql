{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'cards') }}
),

cleaned as (
    select
        card_id,
        customer_id,
        lower(card_type) as card_type,
        lower(card_status) as card_status,
        issued_date,
        expired_date
    from source
),

joined_card_types as (
    select
        c.*,
        ct.network,
        ct.features
    from cleaned c
    left join {{ ref('card_types') }} ct
        on c.card_type = ct.card_type
)

select
    {{ dbt_utils.generate_surrogate_key(['card_id']) }} as card_sk,
    *
from joined_card_types
