

SELECT 
	di.driver_id,
	dm.active_status,
	dm.driver_rating,
	di.incentive_program,
	di.bonus_amount,
	di.delivery_target,
	di.actual_deliveries,
	di.bonus_qualified
FROM "ae_exam_db"."main"."model_log_driver_incentive" di 
JOIN "ae_exam_db"."main"."model_dim_drivers" dm
ON dm.driver_id = di.driver_id