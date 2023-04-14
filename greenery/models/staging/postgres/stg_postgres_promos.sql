with source AS(
    SELECT * FROM {{source('postgres', 'promos')}}
),

refined AS(
    SELECT 
        promo_id,
        discount,
        status
    FROM source
)

SELECT * FROM refined