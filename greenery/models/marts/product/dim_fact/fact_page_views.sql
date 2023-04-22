{{
    config(
        MATERIALIZED = 'table'
    )
}}

WITH product_views_agg AS(
    SELECT 
        pv.product_guid,
        pr.name,
        pv.view_date,
        pv.page_view
    FROM {{ref('int_page_views')}} AS pv
    LEFT JOIN {{ref('stg_postgres_products')}} AS pr 
        ON pv.product_guid = pr.product_guid
)

SELECT * 
FROM product_views_agg
