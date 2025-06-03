{{
  config(
    materialized = 'table',
    schema = 'data_mart'
    )
}}

SELECT 
	di.driver_id,
	dm.vehicle_type,
	dm.region,
	dm.active_status,
	dm.driver_rating,
	di.incentive_program,
	di.applied_date,
	di.bonus_amount,
	di.delivery_target,
	di.actual_deliveries,
	di.bonus_qualified
FROM {{ ref('model_log_driver_incentive') }} di 
JOIN {{ ref('model_dim_drivers') }} dm
ON dm.driver_id = di.driver_id 