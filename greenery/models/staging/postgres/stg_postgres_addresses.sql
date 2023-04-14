{{
    config(
        MATERIALIZED = 'table'
    )
}}

with source as (
    SELECT * FROM {{ source('postgres', 'addresses')}}
),

refined AS (
    SELECT 
        address_id AS address_guid,
        address,
        state,
        lpad(zipcode, 5, 0) AS zip_code,
        country
    FROM source
)

SELECT * FROM refined