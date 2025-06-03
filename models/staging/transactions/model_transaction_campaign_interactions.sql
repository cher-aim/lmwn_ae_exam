SELECT *
FROM {{ source('raw', 'campaign_interactions') }}