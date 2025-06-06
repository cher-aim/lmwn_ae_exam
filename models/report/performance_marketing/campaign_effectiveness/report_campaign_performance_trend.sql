{{
  config(
    materialized = 'table',
    schema = 'report_performance_marketing'
    )
}}

WITH daily_campaign_metrics AS (
SELECT
    DATE(interaction_datetime) as interaction_date,
    year,
    month,
    day_type,
    day_name,
    campaign_id,
    campaign_name,
    campaign_type,
    COUNT(CASE WHEN event_type = 'impression' THEN 1 END) AS daily_impressions,
    COUNT(CASE WHEN event_type = 'click' THEN 1 END) AS daily_clicks,
    COUNT(CASE WHEN event_type = 'conversion' THEN 1 END) AS daily_conversions,
    COUNT(DISTINCT customer_id) AS customers_reached,
    COUNT(DISTINCT CASE 
        WHEN order_id IS NOT NULL AND order_status = 'completed' 
        THEN customer_id 
    END) AS customers_purchased,
    COUNT(DISTINCT CASE 
        WHEN order_status = 'completed' AND is_new_customer = TRUE THEN customer_id 
    END) AS new_customers_acquired,
    SUM(ad_cost) AS daily_cost,
    SUM(CASE 
        WHEN order_status = 'completed' THEN revenue ELSE 0 
    END) AS daily_revenue,
    COUNT(DISTINCT CASE 
        WHEN order_status = 'completed' THEN order_id 
    END) AS completed_orders
FROM {{ ref('model_mart_campaign_interactions') }} mpm 
GROUP BY 
    DATE(interaction_datetime), 
    year, 
    month, 
    day_type, 
    day_name,
    campaign_id, 
    campaign_name, 
    campaign_type
)
SELECT 
	interaction_date,
	year,
    month,
    day_type,
    day_name,
    campaign_id,
    campaign_name,
    campaign_type,
    daily_impressions,
    daily_clicks,
    daily_conversions,
    customers_reached,
    customers_purchased,
    daily_cost,
    daily_revenue,
    completed_orders,
    CASE 
        WHEN customers_reached > 0 
        THEN ROUND((customers_purchased::FLOAT / customers_reached::FLOAT) * 100, 2)
        ELSE 0 
    END AS purchase_rate_pct,
    CASE 
        WHEN daily_cost > 0 
        THEN ROUND(daily_revenue / daily_cost, 2)
        ELSE 0 
    END AS daily_return_on_ad_spend,
    CASE 
        WHEN new_customers_acquired > 0 
        THEN ROUND(daily_cost / new_customers_acquired, 2)
        ELSE NULL 
    END AS daily_cost_per_acquired_customer
FROM daily_campaign_metrics