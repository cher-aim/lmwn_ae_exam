
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "ae_exam_db"."main"."model_dim_campaigns"

where not(campaign_id LIKE 'CMP%')


  
  
      
    ) dbt_internal_test