{{
    config(
        MATERIALIZED = 'table'
    )
}}

WITH product_orders_agg AS(
SELECT 
    po.order_date,
    po.product_guid,
    pr.name
FROM {{ref('int_product_orders')}} AS po
LEFT JOIN {{ref('stg_postgres_products')}} AS pr
    ON po.product_guid = pr.product_guid
GROUP BY po.product_guid, pr.name, po.order_date 
)

SELECT * FROM product_orders_agg