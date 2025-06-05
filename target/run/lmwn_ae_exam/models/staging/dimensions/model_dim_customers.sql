
  
  create view "ae_exam_db"."main"."model_dim_customers__dbt_tmp" as (
    SELECT *
FROM "ae_exam_db"."main"."customers_master"
  );
