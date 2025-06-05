

WITH restaurant_complaints AS (
    SELECT
        restaurant_id,
        customer_id,
        MIN(opened_datetime) AS first_complaint_date
    FROM "ae_exam_db"."main_data_mart_customer_service"."model_mart_restaurant_related_tickets"
    WHERE ticket_id IS NOT NULL AND issue_type = 'food'
    GROUP BY restaurant_id, customer_id
),
customer_returns AS (
    SELECT
        mart.restaurant_id,
        COUNT(DISTINCT CASE 
	        WHEN mart.order_status = 'completed' AND mart.order_datetime > rc.first_complaint_date AND mart.ticket_id IS NULL  
            THEN mart.customer_id 
        END) AS total_customers_return
    FROM "ae_exam_db"."main_data_mart_customer_service"."model_mart_restaurant_related_tickets" mart
    JOIN restaurant_complaints rc 
    ON mart.restaurant_id = rc.restaurant_id 
    AND mart.customer_id = rc.customer_id  
    GROUP BY mart.restaurant_id
),
restaurant_metrics AS (
    SELECT
        main.restaurant_id,
        COUNT(DISTINCT order_id) AS total_orders,
        COUNT(CASE WHEN ticket_id IS NOT NULL THEN 1 END) AS total_complaints,
        COUNT(DISTINCT CASE WHEN issue_type = 'food' AND issue_sub_type = 'wrong_item' AND ticket_id IS NOT NULL THEN ticket_id END) AS food_wrong_item_complaints,
        COUNT(DISTINCT CASE WHEN issue_type = 'food' AND issue_sub_type = 'cold' AND ticket_id IS NOT NULL THEN ticket_id END) AS food_cold_complaints,
        ROUND(AVG(CASE WHEN ticket_id IS NOT NULL THEN resolved_duration_hours END), 2) AS avg_resolution_hours,
        SUM(CASE WHEN ticket_id IS NOT NULL AND compensation_amount IS NOT NULL THEN compensation_amount END) AS total_compensation,
        COUNT(DISTINCT CASE WHEN ticket_id IS NOT NULL AND issue_type = 'food' THEN customer_id END) AS total_customers_complained,
        COALESCE(cr.total_customers_return, 0) AS total_customers_return
    FROM "ae_exam_db"."main_data_mart_customer_service"."model_mart_restaurant_related_tickets" AS main
    LEFT JOIN customer_returns AS cr ON main.restaurant_id = cr.restaurant_id
    GROUP BY main.restaurant_id, cr.total_customers_return  
)
SELECT 
    restaurant_id,
    total_orders,
    total_complaints,
    ROUND(CASE WHEN total_orders <> 0 THEN (total_complaints * 100.0 / total_orders) END, 2) AS complaint_pct,
    food_wrong_item_complaints,
    food_cold_complaints,
    avg_resolution_hours,
    total_compensation,
    total_customers_complained,
    total_customers_return,
    ROUND(CASE WHEN total_customers_complained <> 0 THEN (total_customers_return * 100.0 / total_customers_complained) END, 2) AS customer_retention_rate_percent
FROM restaurant_metrics