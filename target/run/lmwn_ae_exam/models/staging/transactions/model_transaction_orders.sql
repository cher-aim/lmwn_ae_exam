
  
  create view "ae_exam_db"."main"."model_transaction_orders__dbt_tmp" as (
    SELECT *
FROM "ae_exam_db"."main"."order_transactions"
  );
