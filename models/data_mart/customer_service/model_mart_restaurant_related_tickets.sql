{{
  config(
    materialized = 'table',
    schema = 'data_mart_customer_service'
    )
}}

SELECT 
	ticket.ticket_id,
	ord.restaurant_id,
	ord.customer_id,
	ord.order_id,
	issue_type,
	issue_sub_type,
	compensation_amount,
	opened_datetime, 
	resolved_datetime,
    order_datetime,
    order_status,
    CASE WHEN status = 'resolved' THEN DATEDIFF('hour', opened_datetime, resolved_datetime) END AS resolved_duration_hours
FROM {{ ref('model_transaction_orders') }} AS ord 
LEFT JOIN {{ ref('model_transaction_support_tickets') }} ticket
ON ord.order_id = ticket.order_id
LEFT JOIN {{ ref('model_dim_restaurants') }} restaurant 
ON ticket.restaurant_id = restaurant.restaurant_id 