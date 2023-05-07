WITH product_funnel_1 AS(
    SELECT 
        pe.session_guid AS session_guid,
        pe.product_guid,
        pe.event_type,
        ss.purchase
    FROM {{ref('stg_postgres_events')}} AS pe
    LEFT JOIN {{ref('int_successful_sessions')}} ss
        ON pe.session_guid = ss.session_guid
    WHERE event_type = 'page_view'
        OR event_type = 'add_to_cart'
),
product_funnel_2 AS(
    SELECT 
        product_guid,
        event_type,
        SUM(purchase)/COUNT(purchase) AS purchase_share,
        SUM(purchase) AS purchased,
        COUNT(purchase) AS total
    FROM product_funnel_1
    GROUP BY event_type, product_guid
)

SELECT *
FROM product_funnel_2