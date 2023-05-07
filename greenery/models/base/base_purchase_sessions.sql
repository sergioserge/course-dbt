{{
    config(
        MATERIALIZED = 'table'
    )
}}

WITH purchase_sessions AS(
    SELECT 
        session_guid,
        SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS purchase_done
    FROM {{ref('stg_postgres_events')}}
    GROUP BY session_guid)
    
SELECT *
FROM purchase_sessions
