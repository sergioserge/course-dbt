{{
    config(
        MATERIALIZED = 'table'
    )
}}

-- instead of creating the 1,2,3+ buckets I would do it like that because I assume that this would be the best 
-- aggregated level of data to work with in an BI tool
-- 
WITH aggregated AS(
    SELECT  
        user_guid, 
        COUNT(*) AS purchase_frequency
FROM {{ref('stg_postgres_orders')}}
GROUP BY user_guid)

SELECT  
    purchase_frequency,
    COUNT(user_guid) AS user_count
FROM aggregated
GROUP BY 1
ORDER BY 1