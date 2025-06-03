SELECT *
FROM {{ source('raw', 'restaurants_master') }} 