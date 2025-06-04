{{
  config(
    materialized = 'table',
    schema = 'report_customer_service'
    )
}}

WITH total_orders_per_driver AS (
	SELECT 	
		driver_id,
		COUNT(order_id) AS total_orders
	FROM {{ ref('model_mart_driver_related_tickets') }}
	GROUP BY driver_id
)
SELECT 
	st.driver_id,
	COUNT(*) AS total_complaints,
	COUNT(CASE WHEN issue_type = 'rider' AND issue_sub_type = 'no_mask' THEN 1 END) AS rider_no_mask_issue_count,
	COUNT(CASE WHEN issue_type = 'rider' AND issue_sub_type = 'rude' THEN 1 END) AS rider_rude_issue_count,
	COUNT(CASE WHEN issue_type = 'delivery' AND issue_sub_type = 'late' THEN 1 END) AS delivery_late_issue_count,
	COUNT(CASE WHEN issue_type = 'delivery' AND issue_sub_type = 'not_delivered' THEN 1 END) AS not_delivered_issue_count,
	ROUND(AVG(resolved_duration_hours), 2) AS avg_time_to_solve,
	ROUND(AVG(csat_score), 2) AS avg_csat_score,
	ROUND((COUNT(*) / total_orders *100), 2) AS complaint_rate_pct,
	AVG(driver_rating) AS avg_driver_rating
FROM {{ ref('model_mart_driver_related_tickets') }} st 
JOIN total_orders_per_driver tod 
ON st.driver_id = tod.driver_id
WHERE issue_type IN ('rider', 'delivery')
GROUP BY st.driver_id, total_orders 