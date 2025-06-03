{{
  config(
    materialized = 'table',
    schema = 'report_performance_marketing'
    )
}}

WITH new_customer_orders AS (
    SELECT 
        customer_id,
        campaign_id,
        campaign_name,
        campaign_type, 
        order_id,
        order_datetime,
        revenue,
        ROW_NUMBER() OVER (PARTITION BY customer_id, campaign_id ORDER BY order_datetime) as order_sequence
    FROM {{ ref('model_mart_campaign_interactions') }} 
    WHERE is_new_customer = TRUE 
      AND order_status = 'completed'        
),
customer_spending_summary AS (
    SELECT 
        customer_id,
        campaign_id,
        campaign_name,
        campaign_type,
        AVG(revenue) as avg_purchase_value,
        COUNT(CASE WHEN order_sequence > 1 THEN 1 END) as repeat_orders,
        CASE 
            WHEN COUNT(*) > 1 
            THEN DATEDIFF('day', MIN(order_datetime), MAX(order_datetime)) 
            ELSE 0 
        END as days_active
    FROM new_customer_orders
    GROUP BY customer_id, campaign_id, campaign_name, campaign_type
)
, purchase_duration AS (
	SELECT 
		campaign_id,
        campaign_name,
        campaign_type, 
        AVG(minutes_to_purchase) AS avg_minutes_to_purchase,
        SUM(ad_cost) AS total_cost
	FROM {{ ref('model_mart_campaign_interactions') }}
	WHERE is_new_customer = TRUE 
	AND order_status = 'completed'           
    AND minutes_to_purchase IS NOT NULL
	GROUP BY 
		campaign_id,
        campaign_name,
        campaign_type
)
SELECT 
    cs.campaign_id,
    cs.campaign_name,
    cs.campaign_type,
    COUNT(DISTINCT customer_id) as new_customers_with_orders,
    ROUND(AVG(avg_purchase_value), 2) as avg_purchase_value,
    SUM(repeat_orders) as total_repeat_orders_campaign,
    COUNT(CASE WHEN repeat_orders > 0 THEN 1 END) as customers_with_repeat_orders,
    ROUND(AVG(days_active), 1) as avg_days_active,
    avg_minutes_to_purchase AS avg_minutes_to_purchase,
    ROUND((COUNT(CASE WHEN repeat_orders > 0 THEN 1 END)::FLOAT / COUNT(DISTINCT customer_id)::FLOAT) * 100, 2) as repeat_purchase_rate_pct,    
    total_cost
FROM customer_spending_summary cs 
LEFT JOIN purchase_duration pd 
ON cs.campaign_id = pd.campaign_id
GROUP BY cs.campaign_id, cs.campaign_name, cs.campaign_type, avg_minutes_to_purchase, total_cost