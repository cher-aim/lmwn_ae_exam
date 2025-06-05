
  
    
    

    create  table
      "ae_exam_db"."main_data_mart_customer_service"."model_mart_support_tickets__dbt_tmp"
  
    as (
      

SELECT 
	ticket_id,
	EXTRACT(YEAR FROM opened_datetime) AS year,
	EXTRACT(MONTH FROM opened_datetime) AS month,
	CASE 
		WHEN EXTRACT(DOW FROM opened_datetime) IN (0, 6) 
    	THEN 'Weekend' ELSE 'Weekday' 
    END as day_type,
	CASE 
        WHEN EXTRACT(DOW FROM opened_datetime) = 1 THEN 'Monday'
        WHEN EXTRACT(DOW FROM opened_datetime) = 2 THEN 'Tuesday'
        WHEN EXTRACT(DOW FROM opened_datetime) = 3 THEN 'Wednesday'
        WHEN EXTRACT(DOW FROM opened_datetime) = 4 THEN 'Thursday'
        WHEN EXTRACT(DOW FROM opened_datetime) = 5 THEN 'Friday'
        WHEN EXTRACT(DOW FROM opened_datetime) = 6 THEN 'Saturday'
        ELSE 'Sunday'
    END as day_name,
    issue_type,
    issue_sub_type,
    opened_datetime,
    resolved_datetime,
    status,
    csat_score,
    compensation_amount,
    CASE WHEN status = 'resolved' THEN DATEDIFF('hour', opened_datetime, resolved_datetime) END AS resolved_duration_hours
FROM "ae_exam_db"."main"."model_transaction_support_tickets"
    );
  
  