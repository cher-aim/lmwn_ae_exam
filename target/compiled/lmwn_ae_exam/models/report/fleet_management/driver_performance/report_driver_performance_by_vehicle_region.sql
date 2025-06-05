

WITH driver_performance AS (
SELECT 
	driver_region,
	vehicle_type,
    delivery_zone,
	COUNT(*) AS tasks_assigned,
	COUNT(CASE WHEN order_status = 'completed' THEN 1 ELSE 0 END) AS tasks_completed,
    COUNT(CASE WHEN order_status = 'canceled' THEN 1 END) AS tasks_canceled,
	COUNT(CASE WHEN order_status ='failed' THEN 1 END) AS tasks_failed,
	ROUND(COUNT(CASE WHEN order_status = 'completed' THEN 1 END) * 100.0 / COUNT(*), 2) AS completion_rate_percent,
    COUNT(CASE WHEN order_status = 'completed' AND is_late_delivery = FALSE THEN 1 END) AS on_time_deliveries,
    COUNT(CASE WHEN order_status = 'completed' AND is_late_delivery = TRUE THEN 1 END) AS late_deliveries,
    ROUND(AVG(CASE WHEN order_status = 'completed' THEN delivery_minutes END), 2) AS avg_time_to_complete_deliveries
FROM "ae_exam_db"."main_data_mart"."model_mart_driver_order_transactions"
GROUP BY 
	driver_region,
	vehicle_type,
    delivery_zone
)
SELECT 
	driver_region,
	vehicle_type,
    delivery_zone,
    tasks_assigned,
    tasks_completed,
    tasks_canceled,
    tasks_failed,
    completion_rate_percent,
    on_time_deliveries,
    late_deliveries,
    ROUND(late_deliveries * 100.0 / COALESCE(tasks_completed, 0), 2) AS late_delivery_rate_percent,
    avg_time_to_complete_deliveries
FROM driver_performance