SELECT *
FROM {{ source('raw', 'support_ticket_status_logs') }}