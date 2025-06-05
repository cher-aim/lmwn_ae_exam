
  
  create view "ae_exam_db"."main"."model_dim_restaurants__dbt_tmp" as (
    SELECT *
FROM "ae_exam_db"."main"."restaurants_master"
  );
