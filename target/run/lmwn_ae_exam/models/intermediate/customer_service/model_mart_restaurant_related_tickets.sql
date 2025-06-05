
  
    
    

    create  table
      "ae_exam_db"."main_data_mart_customer_service"."model_mart_restaurant_related_tickets__dbt_tmp"
  
    as (
      

SELECT 
	ticket_id,
	ot.restaurant_id,
	ot.customer_id,
	ot.order_id,
	issue_type,
	issue_sub_type,
	compensation_amount,
	opened_datetime, 
	resolved_datetime,
    order_datetime,
    order_status,
    CASE WHEN status = 'resolved' THEN DATEDIFF('hour', opened_datetime, resolved_datetime) END AS resolved_duration_hours
FROM "ae_exam_db"."main"."model_transaction_orders" AS ot
LEFT JOIN "ae_exam_db"."main"."model_transaction_support_tickets" st 
ON ot.order_id = st.order_id
LEFT JOIN "ae_exam_db"."main"."model_dim_restaurants" rm 
ON st.restaurant_id = rm.restaurant_id
    );
  
  