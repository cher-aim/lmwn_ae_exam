
  
  create view "ae_exam_db"."main"."model_log_order_status__dbt_tmp" as (
    SELECT *
FROM "ae_exam_db"."main"."order_log_incentive_sessions_order_status_logs"
  );
