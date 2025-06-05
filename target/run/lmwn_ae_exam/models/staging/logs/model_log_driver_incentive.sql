
  
  create view "ae_exam_db"."main"."model_log_driver_incentive__dbt_tmp" as (
    SELECT *
FROM "ae_exam_db"."main"."order_log_incentive_sessions_driver_incentive_logs"
  );
