
  
  create view "ae_exam_db"."main"."model_log_support_ticket_status__dbt_tmp" as (
    SELECT *
FROM "ae_exam_db"."main"."support_ticket_status_logs"
  );
