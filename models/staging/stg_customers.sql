{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'customers') }}
),

cleaned as (
    select
        customer_id,
        initcap(trim(first_name)) as first_name,
        initcap(trim(last_name)) as last_name,
        lower(trim(email)) as email,
        regexp_replace(phone, '[^0-9]', '') as phone_number,
        initcap(trim(address)) as address,
        initcap(city) as city,
        upper(state) as state,
        upper(country) as country,
        dob,
        created_at
    from source
),

joined_country as (
    select
        c.*,
        cc.country_name,
        cc.region
    from cleaned c
    left join {{ ref('country_codes') }} cc
        on upper(c.country) = cc.country_code
)

select
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk,
    *
from joined_country
