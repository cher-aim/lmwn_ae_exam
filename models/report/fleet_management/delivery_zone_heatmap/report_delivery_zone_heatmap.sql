{{
  config(
    materialized = 'table',
    schema = 'report_fleet_management'
    )
}}

WITH zone_metrics AS (
SELECT 
	delivery_zone,
	city,
	COUNT(*) AS total_delivery_request,
	COUNT(CASE WHEN order_status = 'completed' THEN 1 END) AS completed_deliveries,
	COUNT(CASE WHEN order_status = 'canceled' THEN 1 END)  AS cancelation_deliveries,
    COUNT(CASE WHEN order_status = 'failed' THEN 1 END) AS failure_deliveries,
    AVG(CASE WHEN order_status = 'completed' THEN delivery_minutes END) AS avg_delivery_time_mins,
    COUNT(CASE WHEN is_late_delivery = TRUE THEN 1 ELSE NULL END) AS total_late_deliveries,
    AVG(CASE WHEN is_late_delivery = TRUE THEN delivery_minutes END) AS avg_late_order_time_mins,
    AVG(CASE WHEN is_late_delivery = FALSE THEN delivery_minutes END) AS avg_ontime_order_time_mins,
    COUNT(DISTINCT CASE WHEN active_status = 'active' THEN driver_id END) AS active_drivers,
    COUNT(DISTINCT CASE WHEN active_status = 'inactive' THEN driver_id END) AS inactive_driver,
    AVG(CASE WHEN order_status = 'completed' THEN delivery_distance_km END) AS avg_delivery_distance_km,
FROM {{ ref('model_mart_driver_order_transactions') }}
GROUP BY delivery_zone, city
)
SELECT
    delivery_zone,
    city,
    total_delivery_request,
    completed_deliveries,
    ROUND((completed_deliveries * 100.0 / total_delivery_request), 2) AS completed_rate_pct,
    cancelation_deliveries,
    ROUND((cancelation_deliveries * 100.0 / total_delivery_request), 2) AS cancelation_rate_pct,
    failure_deliveries,
    ROUND((failure_deliveries * 100.0 / total_delivery_request), 2) AS failure_rate_pct,
    active_drivers,
    inactive_driver,
    CASE WHEN active_drivers > 0 AND active_drivers IS NOT NULL THEN 
    ROUND((total_delivery_request/ active_drivers),  2) END AS delivery_requests_per_active_driver,
    CASE WHEN active_drivers > 0 AND active_drivers IS NOT NULL THEN 
    ROUND((completed_deliveries/ active_drivers), 2) AS completed_per_driver,
    total_late_deliveries,
    ROUND((total_late_deliveries * 100.0 / completed_deliveries), 2) AS late_delivery_rate_pct,
    ROUND(avg_delivery_time_mins, 2) AS avg_delivery_time_mins,
    ROUND(avg_late_order_time_mins, 2) AS avg_late_order_time_mins,
    ROUND(avg_ontime_order_time_mins, 2) AS avg_ontime_order_time_mins,
    ROUND(avg_delivery_distance_km, 2) AS avg_delivery_distance_km
FROM zone_metrics
ORDER BY delivery_zone, city