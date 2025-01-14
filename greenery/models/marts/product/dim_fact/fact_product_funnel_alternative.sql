
{% set table_names = ['page_views_phase', 'add_to_cart_phase', 'page_views_total', 'add_to_cart_total']%}
{% set event_types = ['page_view', 'add_to_cart', 'page_view', 'add_to_cart'] %}
{% set values = ['conversion_rate_phase', 'conversion_rate_phase', 'conversion_rate_total', 'conversion_rate_total'] %}
{% set column_names = ['page_view_conversion_phase', 'add_to_cart_conversion_phase', 'page_view_conversion_total', 'add_to_cart_conversion_total'] %}

WITH 
for
{% for table_name in table_names %}
AS(
    SELECT 
        product_guid,
        CASE 
            WHEN event_type = {% for event_type in event_types %} 
            THEN {% for value in values %} 
            ELSE NULL 
        END AS {% for event_type in event_types %}
    FROM {{ref('int_product_funnel')}}
    WHERE {% for column_name in column_names %}  IS NOT NULL
),
add_to_cart_phase AS(
    SELECT 
        product_guid,
        CASE WHEN event_type = 'add_to_cart' THEN conversion_rate_phase ELSE NULL END AS add_to_cart_conversion_phase
    FROM {{ref('int_product_funnel')}}
    WHERE add_to_cart_conversion_phase IS NOT NULL
),
page_views_total AS(
    SELECT 
        product_guid,
        CASE WHEN event_type = 'page_view' THEN conversion_rate_total ELSE NULL END AS page_view_conversion_total
    FROM {{ref('int_product_funnel')}}
    WHERE page_view_conversion_total IS NOT NULL
),
add_to_cart_total AS(
    SELECT 
        product_guid,
        CASE WHEN event_type = 'add_to_cart' THEN conversion_rate_total ELSE NULL END AS add_to_cart_conversion_total
    FROM {{ref('int_product_funnel')}}
    WHERE add_to_cart_conversion_total IS NOT NULL
),
all_merged AS(
    SELECT 
        pvp.product_guid,
        pp.name,
        1 AS total_views,
        page_view_conversion_phase,
        add_to_cart_conversion_phase,
        page_view_conversion_total,
        add_to_cart_conversion_total
    FROM page_views_phase pvp
    LEFT JOIN add_to_cart_phase acp
        ON pvp.product_guid = acp.product_guid
    LEFT JOIN page_views_total pvt
        ON pvp.product_guid = pvt.product_guid
    LEFT JOIN add_to_cart_total act
        ON pvp.product_guid = act.product_guid
    LEFT JOIN stg_postgres_products pp
        ON pvp.product_guid = pp.product_guid
)

SELECT *
FROM all_merged