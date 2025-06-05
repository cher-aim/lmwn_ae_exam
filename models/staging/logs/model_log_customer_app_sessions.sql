SELECT *
FROM {{ source('raw', 'customer_app_sessions') }}