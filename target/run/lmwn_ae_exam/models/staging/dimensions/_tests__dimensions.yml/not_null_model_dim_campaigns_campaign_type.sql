
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select campaign_type
from "ae_exam_db"."main"."model_dim_campaigns"
where campaign_type is null



  
  
      
    ) dbt_internal_test