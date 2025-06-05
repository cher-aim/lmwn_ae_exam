
  
    
    

    create  table
      "ae_exam_db"."main_report_performance_marketing"."report_retargeting_retention_behavior__dbt_tmp"
  
    as (
      

WITH retargeting_customers AS (
	SELECT 
		customer_id,
	    campaign_id,
	    campaign_name,
	    campaign_type,
	    customer_segment,
	    MIN(CASE WHEN order_status = 'completed' THEN order_datetime END) AS first_return_order_date
    FROM "ae_exam_db"."main_data_mart_performance_marketing"."model_mart_campaign_interactions"
    WHERE campaign_type = 'retargeting'
    GROUP BY 
    	customer_id,
    	campaign_id,
    	campaign_name,
    	campaign_type,
    	customer_segment
)
, post_return_orders AS (
    SELECT 
        rc.customer_id,
        rc.campaign_id,
        rc.campaign_name,
        rc.customer_segment,
        rc.first_return_order_date,
        MAX(oh.order_datetime) AS recent_day_customers_purchase
    FROM retargeting_customers rc 
    LEFT JOIN "ae_exam_db"."main_data_mart_performance_marketing"."model_mart_interacting_customer_orders" oh 
    ON rc.customer_id = oh.customer_id 
    AND oh.order_datetime > rc.first_return_order_date
    AND oh.order_status = 'completed'
    WHERE first_return_order_date IS NOT NULL
    GROUP BY 
        rc.customer_id,
        rc.campaign_id,
        rc.campaign_name,
        rc.customer_segment,
        rc.first_return_order_date
)
SELECT 
	campaign_id,
    campaign_name,
    customer_segment,
    AVG(DATEDIFF('day', first_return_order_date, recent_day_customers_purchase)) AS avg_days_active_after_return
FROM post_return_orders
GROUP BY 
	campaign_id,
    campaign_name,
    customer_segment
    );
  
  