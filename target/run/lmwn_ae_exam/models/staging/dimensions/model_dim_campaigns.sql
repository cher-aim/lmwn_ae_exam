
  
  create view "ae_exam_db"."main"."model_dim_campaigns__dbt_tmp" as (
    SELECT *
FROM "ae_exam_db"."main"."campaign_master"
  );
