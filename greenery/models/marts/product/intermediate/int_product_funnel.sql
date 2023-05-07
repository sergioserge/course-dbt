WITH product_funnel AS(
    SELECT  
        product_guid,
        event_type,
        1 AS page_view,
        purchase_share AS conversion_rate_phase,
        CASE 
            WHEN event_type = 'add_to_cart' THEN
                LAG(total,1) OVER(ORDER BY product_guid ASC, event_type DESC) 
            ELSE total
        END AS total_count,
        purchased/total_count AS conversion_rate_total
    FROM {{ref('base_product_funnel')}}
    ORDER BY product_guid ASC, event_type DESC
)

SELECT * 
FROM product_funnel