{{
  config(
    materialized = 'table',
    schema = 'data_mart'
    )
}}

SELECT 
	dm.driver_id,
	st.ticket_id,
    ot.order_id,
	issue_type,
	issue_sub_type,
	opened_datetime,
	resolved_datetime,
	csat_score,
	dm.driver_rating,
    CASE WHEN status = 'resolved' THEN DATEDIFF('hour', opened_datetime, resolved_datetime) END AS resolved_duration_hours
FROM {{ ref('model_transaction_orders') }} AS ot 
LEFT JOIN {{ ref('model_transaction_support_tickets') }} st 
ON ot.driver_id = st.driver_id
LEFT JOIN {{ ref('model_dim_drivers') }} dm 
ON st.driver_id = dm.driver_id 