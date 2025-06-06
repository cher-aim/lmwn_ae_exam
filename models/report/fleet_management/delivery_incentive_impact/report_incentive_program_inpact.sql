{{
  config(
    materialized = 'table',
    schema = 'report_fleet_management'
    )
}}

SELECT 
    incentive_program,
    COUNT(DISTINCT driver_id) AS total_drivers_participating,
    COUNT(DISTINCT CASE WHEN active_status = 'active' THEN driver_id END) AS total_active_drivers_participating,
    SUM(delivery_target) AS total_target_deliveries,
    SUM(actual_deliveries) AS total_actual_deliveries,
    ROUND(SUM(bonus_amount), 2) AS total_bonus_investment,
    SUM(CASE WHEN bonus_qualified = TRUE THEN bonus_amount ELSE 0 END) AS total_bonus_paid,
    ROUND(AVG(driver_rating), 2) AS avg_driver_rating
FROM {{ ref('model_mart_driver_incentive_logs') }} 
GROUP BY incentive_program