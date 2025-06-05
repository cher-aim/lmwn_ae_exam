SELECT *
FROM {{ source('raw', 'driver_incentive_logs') }}