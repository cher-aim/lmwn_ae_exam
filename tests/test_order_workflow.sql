WITH order_workflow AS (
    SELECT
    order_id,
    COUNT(*) AS total_status_changes,
    COUNT(CASE WHEN status = 'created' THEN 1 END) as created_count,
    COUNT(CASE WHEN status = 'accepted' THEN 1 END) as accepted_count,
    COUNT(CASE WHEN status = 'picked_up' THEN 1 END) as picked_up_count,
    COUNT(CASE WHEN status = 'completed' THEN 1 END) as completed_count
  	FROM {{ ref('stg_order_status_logs') }} olisosl 
  	GROUP BY 
  	order_id
)
SELECT *
FROM order_workflow
WHERE total_status_changes > 4 OR created_count > 1 OR accepted_count > 1 OR picked_up_count > 1 OR completed_count > 1