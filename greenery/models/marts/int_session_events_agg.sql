{{
    config(
        MATERIALIZED = 'table'
    )
}}

WITH aggregated_events AS(
    SELECT 
        user_guid, 
        session_guid,
        SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view,
        SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart,
        SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checkout,
        SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS package_shipped,
        MIN(created_at) AS first_session_event_time,
        MAX(created_at) AS last_session_event_time
    FROM {{ref('stg_postgres_events')}}
    GROUP BY 1, 2
)

SELECT * FROM aggregated_events