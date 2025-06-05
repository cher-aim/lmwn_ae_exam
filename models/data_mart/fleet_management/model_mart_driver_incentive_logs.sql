{{
  config(
    materialized = 'table',
    schema = 'data_mart_fleet_management'
    )
}}

SELECT 
	incentive.driver_id,
	driver.active_status,
	driver.driver_rating,
	incentive.incentive_program,
	incentive.bonus_amount,
	incentive.delivery_target,
	incentive.actual_deliveries,
	incentive.bonus_qualified
FROM {{ ref('model_log_driver_incentive') }} incentive
JOIN {{ ref('model_dim_drivers') }} driver
ON driver.driver_id = incentive.driver_id  