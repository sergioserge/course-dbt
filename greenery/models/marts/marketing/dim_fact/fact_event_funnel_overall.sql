WITH event_shares AS(
    SELECT 
        session_guid,
        page_view AS total_count,
        add_to_cart /total_count AS add_to_cart_share,
        checkout / total_count AS checkout_share
    FROM {{ref('int_session_events_agg')}}
)

SELECT 
    SUM(add_to_cart_share)/COUNT(total_count) AS add_to_cart_share,
    SUM(checkout_share)/COUNT(total_count) AS checkout_share
FROM event_shares