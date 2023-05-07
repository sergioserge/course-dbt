WITH agg_conversions AS(
    SELECT 
        1 as total_views,
        SUM(page_view_conversion_phase)/COUNT(page_view_conversion_phase) AS avg_page_view_conversion_phase,
        SUM(add_to_cart_conversion_phase)/COUNT(add_to_cart_conversion_phase) AS avg_add_to_cart_conversion_phase,
        SUM(page_view_conversion_total)/COUNT(page_view_conversion_total) AS avg_page_view_conversion_total,
        SUM(add_to_cart_conversion_total)/COUNT(add_to_cart_conversion_total) AS avg_add_to_cart_conversion_total
    FROM {{ref('fact_product_funnel')}}
)

SELECT *
FROM agg_conversions