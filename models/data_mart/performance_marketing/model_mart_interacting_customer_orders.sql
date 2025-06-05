{{
  config(
    materialized = 'table',
    schema = 'data_mart_performance_marketing'
    )
}}

SELECT 
	ot.order_id,
	ot.customer_id,
	ot.restaurant_id,
	ot.driver_id,
	ot.order_datetime,
	ot.pickup_datetime,
	ot.delivery_datetime,
	ot.order_status,
	ot.total_amount 
FROM {{ ref('model_transaction_orders') }} ot 
WHERE customer_id IN (
	SELECT DISTINCT customer_id 
	FROM {{ ref('model_transaction_campaign_interactions') }}
)