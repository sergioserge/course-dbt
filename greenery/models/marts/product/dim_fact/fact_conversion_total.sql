SELECT 
    SUM(purchase_done)/COUNT(purchase_done) AS total_conversion_rate
FROM {{ref('base_purchase_sessions')}}