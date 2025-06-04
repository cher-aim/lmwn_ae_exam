{{
  config(
    materialized = 'table',
    schema = 'report_fleet_management'
    )
}}

SELECT 
	driver_id,
	SUM(CASE WHEN bonus_qualified = TRUE THEN bonus_amount ELSE 0 END) AS total_bonus_paid
FROM {{ ref('model_mart_driver_incentive_logs') }} 
GROUP BY 
	driver_id 