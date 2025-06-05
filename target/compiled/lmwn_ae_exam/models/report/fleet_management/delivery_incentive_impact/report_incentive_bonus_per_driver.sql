

SELECT 
	driver_id,
	SUM(CASE WHEN bonus_qualified = TRUE THEN bonus_amount ELSE 0 END) AS total_bonus_paid
FROM "ae_exam_db"."main_data_mart_fleet_management"."model_mart_driver_incentive_logs" 
GROUP BY 
	driver_id