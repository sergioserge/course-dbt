{{
    config(
        MATERIALIZED = 'table'
    )
}}

WITH product_orders_agg AS(
    SELECT 
        ord.order_guid,
        ord.created_at::DATE AS order_date,
        ordi.product_guid
    FROM {{ref('stg_postgres_orders')}} AS ord
    LEFT JOIN {{ref('stg_postgres_order_items')}} AS ordi
        ON ord.order_guid = ordi.order_guid
)

SELECT * 
FROM product_orders_agg