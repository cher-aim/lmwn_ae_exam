{{
  config(
    materialized = 'table',
    schema = 'report_customer_service'
    )
}}

WITH driver_metrics AS (
    SELECT 
        driver_id,
        COUNT(DISTINCT order_id) AS total_orders,
        COUNT(DISTINCT CASE WHEN ticket_id IS NOT NULL THEN ticket_id END) AS total_complaints,
        COUNT(DISTINCT CASE WHEN issue_type = 'rider' AND issue_sub_type = 'no_mask' AND ticket_id IS NOT NULL THEN ticket_id END) AS rider_no_mask_complaints,
        COUNT(DISTINCT CASE WHEN issue_type = 'rider' AND issue_sub_type = 'rude' AND ticket_id IS NOT NULL THEN ticket_id END) AS rider_rude_complaints,
        COUNT(CASE WHEN issue_type = 'delivery' AND issue_sub_type = 'late' AND ticket_id IS NOT NULL THEN ticket_id END) AS delivery_late_complaints,
        COUNT(CASE WHEN issue_type = 'delivery' AND issue_sub_type = 'not_delivered' AND ticket_id IS NOT NULL THEN ticket_id END) AS not_delivered_complaints,
        ROUND(AVG(CASE WHEN ticket_id IS NOT NULL THEN resolved_duration_hours END), 2) AS avg_resolution_hours,
        ROUND(AVG(CASE WHEN ticket_id IS NOT NULL THEN csat_score END), 2) AS avg_csat_score
    FROM {{ ref('model_mart_driver_related_tickets') }}
    WHERE driver_id IS NOT NULL 
    GROUP BY driver_id 
)
SELECT 
    driver_id,
    total_orders,
    total_complaints,
    rider_no_mask_complaints,
    rider_rude_complaints
    delivery_late_complaints,
    not_delivered_complaints,
    ROUND((total_complaints/ total_orders)*100.0, 2) AS complaint_rate_pct,
    avg_resolution_hours,
    avg_csat_score
FROM driver_metrics 
