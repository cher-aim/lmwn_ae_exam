{{
  config(
    materialized = 'table',
    schema = 'report_performance_marketing'
    )
}}

SELECT 
	campaign_id,
	campaign_name,
	campaign_type,
	channel,
	platform,
	COUNT(DISTINCT customer_id) AS total_acquired_customers
FROM {{ ref('model_mart_campaign_interactions') }} 
WHERE is_new_customer = TRUE AND order_status = 'completed'
GROUP BY 
	campaign_id,
	campaign_name,
	campaign_type,
	channel,
	platform