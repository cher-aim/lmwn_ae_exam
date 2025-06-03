{{
  config(
    materialized = 'table',
    schema = 'report_performance_marketing'
    )
}}

WITH retargeting_customers AS (
	 SELECT
        customer_id,
        campaign_id,
        campaign_name,
        campaign_type,
        customer_segment,
        MIN(interaction_datetime) AS first_retargeting_interaction,
        MIN(CASE WHEN order_status = 'completed' THEN order_datetime END) AS first_order_after_retargeting,
        SUM(CASE WHEN order_status = 'completed' THEN revenue ELSE 0 END) as customer_spend_after_retargeting
    FROM {{ ref('model_mart_campaign_interactions') }}
    WHERE campaign_type = 'retargeting' AND customer_segment IN ('loyal', 'churn_risk', 'inactive')
    GROUP BY 
    	customer_id, 
    	campaign_id, 
    	campaign_name, 
    	campaign_type, 
    	customer_segment	
)
, customer_order_before_retargeting AS (
	SELECT 
        rc.customer_id,
        rc.campaign_id,
        MAX(oh.order_datetime) as last_order_before_retargeting
    FROM retargeting_customers rc
    LEFT JOIN {{ ref('model_mart_interacting_customer_orders') }} oh 
        ON rc.customer_id = oh.customer_id 
        AND oh.order_datetime < rc.first_retargeting_interaction
        AND oh.order_status = 'completed'
    GROUP BY rc.customer_id, rc.campaign_id
)
SELECT 
	rc.campaign_id,
    rc.campaign_name,
    rc.campaign_type,
    rc.customer_segment,
    COUNT(DISTINCT rc.customer_id) AS total_previously_active_customers, 
    COUNT(DISTINCT CASE WHEN rc.first_order_after_retargeting IS NOT NULL THEN rc.customer_id END) as total_returning_customers,
    ROUND((COUNT(DISTINCT CASE WHEN rc.first_order_after_retargeting IS NOT NULL THEN rc.customer_id END)::FLOAT / 
         COUNT(DISTINCT rc.customer_id)::FLOAT) * 100, 2
    ) as return_rate_pct, -- TOTAL_RETURNING_CUSTOMERS/ TOTAL_TARGETED_CUSTOMERS * 100 
    SUM(rc.customer_spend_after_retargeting) as total_spend_generated,
    AVG(rc.customer_spend_after_retargeting) as avg_spend_per_customer,
    ROUND(AVG(CASE 
            WHEN cb.last_order_before_retargeting IS NOT NULL AND rc.first_order_after_retargeting IS NOT NULL
            THEN DATEDIFF('day', cb.last_order_before_retargeting, rc.first_order_after_retargeting)
        END), 1
    ) as avg_days_gap_to_return
FROM retargeting_customers rc
LEFT JOIN customer_order_before_retargeting cb 
ON rc.customer_id = cb.customer_id 
AND rc.campaign_id = cb.campaign_id
GROUP BY 
    rc.campaign_id, 
    rc.campaign_name, 
    rc.campaign_type, 
    rc.customer_segment