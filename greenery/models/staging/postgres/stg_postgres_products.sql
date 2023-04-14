with source AS(
    SELECT * FROM {{source('postgres', 'products')}}
),

refined AS(
    SELECT
        product_id AS product_guid,
        name,
        price,
        inventory
    FROM source
) 

SELECT * FROM refined