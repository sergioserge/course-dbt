{{
    config(
        MATERIALIZED = 'table'
    )
}}

WITH product_views_agg AS(
    SELECT 
        product_guid,
        created_at::DATE AS view_date,
        SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart
    FROM {{ref('stg_postgres_events')}}
    GROUP BY product_guid, view_date
    HAVING product_guid IS NOT NULL
)

SELECT * FROM product_views_agg