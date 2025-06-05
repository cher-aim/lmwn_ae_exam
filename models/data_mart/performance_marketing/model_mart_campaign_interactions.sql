{{
  config(
    materialized = 'table',
    schema = 'data_mart_performance_marketing'
    )
}}

SELECT  
	interaction.interaction_id,
	interaction.interaction_datetime,
	EXTRACT(YEAR FROM interaction.interaction_datetime) AS year,
	EXTRACT(MONTH FROM interaction.interaction_datetime) AS month,
	CASE 
		WHEN EXTRACT(DOW FROM interaction.interaction_datetime) IN (0, 6) 
    	THEN 'Weekend' ELSE 'Weekday' 
    END as day_type,
	CASE 
        WHEN EXTRACT(DOW FROM interaction.interaction_datetime) = 1 THEN 'Monday'
        WHEN EXTRACT(DOW FROM interaction.interaction_datetime) = 2 THEN 'Tuesday'
        WHEN EXTRACT(DOW FROM interaction.interaction_datetime) = 3 THEN 'Wednesday'
        WHEN EXTRACT(DOW FROM interaction.interaction_datetime) = 4 THEN 'Thursday'
        WHEN EXTRACT(DOW FROM interaction.interaction_datetime) = 5 THEN 'Friday'
        WHEN EXTRACT(DOW FROM interaction.interaction_datetime) = 6 THEN 'Saturday'
        ELSE 'Sunday'
    END as day_name,
	interaction.campaign_id,
	interaction.customer_id,
	customer.customer_segment,
	customer.status AS customer_status, 
	interaction.order_id,
	campaign.campaign_name,
	campaign.campaign_type,
	campaign.start_date AS campaign_start_date,
	campaign.end_date AS campaign_end_date,
	campaign.budget AS campaign_budget,
	campaign.cost_model,
	campaign.objective AS campaign_objective,
	campaign.channel,
	campaign.targeting_strategy,
	campaign.is_active AS campaign_status,
	interaction.event_type,
	interaction.platform,
	interaction.device_type,
	interaction.ad_cost,
	interaction.revenue,
	interaction.is_new_customer,
	ord.order_datetime,
	ord.delivery_datetime,
	ord.order_status,
	CASE 
		WHEN interaction.order_id IS NOT NULL AND order_datetime IS NOT NULL 
		THEN DATEDIFF('minute', interaction.interaction_datetime, ord.order_datetime)
	END AS minutes_to_conversion,
	CASE 
		WHEN interaction.order_id IS NOT NULL AND order_status = 'completed' 
		THEN DATEDIFF('minute', interaction.interaction_datetime, ord.order_datetime)
	END AS minutes_to_purchase
FROM {{ ref('model_transaction_campaign_interactions') }} AS interaction 
JOIN {{ ref('model_dim_campaigns') }} AS campaign 
ON interaction.campaign_id = campaign.campaign_id
JOIN {{ ref('model_transaction_orders') }} AS ord
ON ord.order_id = interaction.order_id 
JOIN {{ ref('model_dim_customers') }} AS customer 
ON customer.customer_id = interaction.customer_id