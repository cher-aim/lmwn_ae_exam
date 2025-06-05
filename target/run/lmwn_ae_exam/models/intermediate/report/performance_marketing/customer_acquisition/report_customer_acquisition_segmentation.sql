
  
    
    

    create  table
      "ae_exam_db"."main_report_performance_marketing"."report_customer_acquisition_segmentation__dbt_tmp"
  
    as (
      

SELECT 
	campaign_id,
	campaign_name,
	campaign_type,
	channel,
	platform,
	COUNT(DISTINCT customer_id) AS total_acquired_customers
FROM main_data_mart.model_mart_campaign_interactions 
WHERE is_new_customer = TRUE AND order_status = 'completed'
GROUP BY 
	campaign_id,
	campaign_name,
	campaign_type,
	channel,
	platform
    );
  
  