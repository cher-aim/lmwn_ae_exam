{{
  config(
    materialized = 'table',
    schema = 'report_performance_marketing'
    )
}}

WITH overall_campaign_analysis AS (
SELECT 
	campaign_id,
	campaign_name,
	campaign_type,
	campaign_objective,
	cost_model,
	SUM(ad_cost) AS total_campaign_cost,
	SUM(CASE WHEN order_status = 'completed' THEN revenue ELSE 0 END) AS total_revenue,
	COUNT(DISTINCT customer_id) as customers_reached,
	COUNT(DISTINCT CASE 
        WHEN order_id IS NOT NULL AND order_status = 'completed' 
        THEN customer_id 
    END) as customers_purchased,
    COUNT(DISTINCT CASE 
        WHEN order_status = 'completed' AND is_new_customer = TRUE 
        THEN customer_id 
    END) AS new_customers_acquired,
    COUNT(CASE WHEN event_type = 'impression' THEN 1 END) as total_impressions,
    COUNT(CASE WHEN event_type = 'click' THEN 1 END) as total_clicks,
    COUNT(CASE WHEN event_type = 'conversion' THEN 1 END) as total_conversions
FROM {{ ref('model_mart_campaign_interactions') }} 
GROUP BY 
	campaign_id,
	campaign_name,
	campaign_type,
	campaign_objective,
	cost_model
)
SELECT 
	campaign_id,
	campaign_name,
	campaign_type,
	campaign_objective,
	total_impressions,
    total_clicks,
    total_conversions,
	total_campaign_cost,
	total_revenue,
	customers_reached,
	customers_purchased,
	CASE 
        WHEN customers_reached > 0 
        THEN ROUND((customers_purchased::FLOAT / customers_reached::FLOAT) * 100, 2)
        ELSE 0 
    END AS purchase_rate_pct,
    CASE 
        WHEN customers_reached > 0 
        THEN ROUND((new_customers_acquired::FLOAT / customers_reached::FLOAT) * 100, 2) 
    END AS new_customer_acquisition_rate_pct,
	CASE 
        WHEN total_campaign_cost > 0 
        THEN ROUND(total_revenue / total_campaign_cost, 2)
        ELSE 0 
    END AS return_on_ad_spend,
    CASE 
        WHEN new_customers_acquired > 0 
        THEN ROUND(total_campaign_cost / new_customers_acquired, 2)
        ELSE NULL 
    END AS cost_per_acquired_customer
FROM overall_campaign_analysis