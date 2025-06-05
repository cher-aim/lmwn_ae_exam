SELECT *
FROM {{ source('raw', 'order_status_logs') }}