SELECT *
FROM {{ source('raw', 'order_transactions') }}