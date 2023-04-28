WITH sessions_products AS(
    SELECT 
        pe.session_guid,
        pe.product_guid,
        ps.purchase_done
    FROM {{ref('base_purchase_sessions')}} ps
    INNER JOIN {{ref('stg_postgres_events')}} pe
        ON ps.session_guid = pe.session_guid
    WHERE pe.product_guid IS NOT NULL),
    
sessions_products_count AS(
    SELECT 
        sp.product_guid,
        pp.name,
        COUNT(sp.product_guid) AS purchases_product,
        SUM(purchase_done) AS purchased_sessions,
        COUNT(purchase_done) AS total_sessions,
        purchased_sessions/ total_sessions AS conversion_rate
    FROM sessions_products sp
    INNER JOIN {{ref('stg_postgres_products')}} pp
        ON sp.product_guid = pp.product_guid
    GROUP BY sp.product_guid, pp.name)
    
SELECT * 
FROM sessions_products_count