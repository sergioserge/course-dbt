with source AS(
    SELECT * FROM {{source('postgres', 'orders')}}
),

refined AS(
    SELECT
        order_id AS order_guid,
        user_id AS user_guid,
        promo_id,
        address_id AS address_guid,
        created_at,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id AS tracking_guid,
        shipping_service,
        estimated_delivery_at,
        delivered_at
    FROM source
) 

SELECT * FROM refined