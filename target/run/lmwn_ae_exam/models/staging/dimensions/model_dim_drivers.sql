
  
  create view "ae_exam_db"."main"."model_dim_drivers__dbt_tmp" as (
    SELECT *
FROM "ae_exam_db"."main"."drivers_master"
  );
