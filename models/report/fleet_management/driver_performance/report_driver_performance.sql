{{
  config(
    materialized = 'table',
    schema = 'report_fleet_management'
    )
}}

WITH driver_performance AS (
SELECT 
	driver_id,
	COUNT(*) AS tasks_assigned,
	COUNT(CASE WHEN order_status = 'completed' THEN 1 END) AS tasks_completed,
    COUNT(CASE WHEN order_status IS NOT NULL AND pickup_datetime IS NOT NULL THEN 1 END) AS task_accepted, 
    COUNT(CASE WHEN order_status = 'canceled' THEN 1 END) AS tasks_canceled,
	COUNT(CASE WHEN order_status ='failed' THEN 1 END) AS tasks_failed,
	ROUND(COUNT(CASE WHEN order_status = 'completed' THEN 1 END) * 100.0 / COUNT(*), 2) AS completion_rate_percent,
    COUNT(CASE WHEN order_status = 'completed' AND is_late_delivery = FALSE THEN 1 END) AS on_time_deliveries,
    COUNT(CASE WHEN order_status = 'completed' AND is_late_delivery = TRUE THEN 1 END) AS late_deliveries,
    ROUND(AVG(CASE WHEN order_status = 'completed' THEN delivery_minutes END), 2) AS avg_time_to_complete
FROM {{ ref('model_mart_driver_order_transactions') }}
GROUP BY 
	driver_id
)
SELECT 
	driver_id,
    tasks_assigned,
    tasks_completed,
    task_accepted,
    tasks_canceled,
    tasks_failed,
    completion_rate_percent,
    on_time_deliveries,
    late_deliveries,
    CASE WHEN tasks_completed IS NOT NULL OR tasks_completed > 0 THEN 
    ROUND(late_deliveries * 100.0 / tasks_completed, 2) END AS late_delivery_rate_percent,
    avg_time_to_complete
FROM driver_performance