

SELECT 
	issue_type,
	issue_sub_type,
	COUNT(*) AS total_reported_count,
	ROUND((COUNT(*) / (SELECT COUNT(*) FROM "ae_exam_db"."main_data_mart_customer_service"."model_mart_support_tickets")) * 100, 2) AS pct_of_total,
	COUNT(CASE WHEN status = 'resolved' AND resolved_datetime IS NOT NULL  THEN 1 END) AS resolved_count,
    ROUND(COUNT(CASE WHEN resolved_datetime IS NOT NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS resolution_rate_percent,
	ROUND(AVG(CASE WHEN status = 'resolved' AND resolved_datetime IS NOT NULL 
	    THEN  resolved_duration_hours
	END), 2)  AS avg_resolution_time_hours,
	ROUND(AVG(CASE WHEN compensation_amount > 0 THEN compensation_amount END), 2) AS avg_compensation_paid,
	ROUND(SUM(compensation_amount), 2) AS total_compensation_paid
FROM "ae_exam_db"."main_data_mart_customer_service"."model_mart_support_tickets"
GROUP BY 
	issue_type,
	issue_sub_type