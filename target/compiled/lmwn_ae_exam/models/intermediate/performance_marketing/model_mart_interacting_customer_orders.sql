

WITH customer_interactions AS (
	SELECT DISTINCT customer_id
	FROM "ae_exam_db"."main"."model_transaction_campaign_interactions" ci 
)
SELECT 
	order_id,
	ot.customer_id,
	restaurant_id,
	driver_id,
	order_datetime,
	pickup_datetime,
	delivery_datetime,
	order_status,
	total_amount 
FROM "ae_exam_db"."main"."model_transaction_orders" ot 
JOIN customer_interactions ci 
ON ot.customer_id = ci.customer_id