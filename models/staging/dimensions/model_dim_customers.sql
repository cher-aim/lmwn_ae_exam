SELECT *
FROM {{ source('raw', 'customers_master') }}