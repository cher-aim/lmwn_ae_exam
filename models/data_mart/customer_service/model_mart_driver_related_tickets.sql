{{
  config(
    materialized = 'table',
    schema = 'data_mart_customer_service'
    )
}}

SELECT 
	ord.driver_id,
	ticket.ticket_id,
    ord.order_id,
	issue_type,
	issue_sub_type,
	opened_datetime,
	resolved_datetime,
	csat_score,
	driver.driver_rating,
    CASE WHEN status = 'resolved' THEN DATEDIFF('hour', opened_datetime, resolved_datetime) END AS resolved_duration_hours
FROM {{ ref('model_transaction_orders') }} AS ord 
LEFT JOIN {{ ref('model_transaction_support_tickets') }} ticket 
ON ord.order_id = ticket.order_id
LEFT JOIN {{ ref('model_dim_drivers') }} driver 
ON ticket.driver_id = driver.driver_id 