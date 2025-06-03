{{
  config(
    materialized = 'table',
    schema = 'data_mart'
    )
}}

SELECT  
	ci.interaction_id,
	ci.interaction_datetime,
	EXTRACT(YEAR FROM ci.interaction_datetime) AS year,
	EXTRACT(MONTH FROM ci.interaction_datetime) AS month,
	CASE 
		WHEN EXTRACT(DOW FROM ci.interaction_datetime) IN (0, 6) 
    	THEN 'Weekend' ELSE 'Weekday' 
    END as day_type,
	CASE 
        WHEN EXTRACT(DOW FROM ci.interaction_datetime) = 1 THEN 'Monday'
        WHEN EXTRACT(DOW FROM ci.interaction_datetime) = 2 THEN 'Tuesday'
        WHEN EXTRACT(DOW FROM ci.interaction_datetime) = 3 THEN 'Wednesday'
        WHEN EXTRACT(DOW FROM ci.interaction_datetime) = 4 THEN 'Thursday'
        WHEN EXTRACT(DOW FROM ci.interaction_datetime) = 5 THEN 'Friday'
        WHEN EXTRACT(DOW FROM ci.interaction_datetime) = 6 THEN 'Saturday'
        ELSE 'Sunday'
    END as day_name,
	ci.campaign_id,
	ci.customer_id,
	c.customer_segment,
	c.status AS customer_status, 
	ci.order_id,
	cm.campaign_name,
	cm.campaign_type,
	cm.start_date AS campaign_start_date,
	cm.end_date AS campaign_end_date,
	cm.budget AS campaign_budget,
	cm.cost_model,
	cm.objective AS campaign_objective,
	cm.channel,
	cm.targeting_strategy,
	cm.is_active AS campaign_status,
	ci.event_type,
	ci.platform,
	ci.device_type,
	ci.ad_cost,
	ci.revenue,
	ci.is_new_customer,
	ot.order_datetime,
	ot.delivery_datetime,
	ot.order_status,
	CASE 
		WHEN ci.order_id IS NOT NULL AND order_datetime IS NOT NULL 
		THEN DATEDIFF('minute', ci.interaction_datetime, ot.order_datetime)
	END as minutes_to_conversion,
	CASE 
		WHEN ci.order_id IS NOT NULL AND order_status = 'completed' 
		THEN DATEDIFF('minute', ci.interaction_datetime, ot.order_datetime)
	END as minutes_to_purchase
FROM {{ ref('model_transaction_campaign_interactions') }} AS ci 
JOIN {{ ref('model_dim_campaigns') }} AS cm 
ON ci.campaign_id = cm.campaign_id
JOIN {{ ref('model_transaction_orders') }} AS ot 
ON ot.order_id = ci.order_id 
JOIN {{ ref('model_dim_customers') }} AS c 
ON c.customer_id = ci.customer_id