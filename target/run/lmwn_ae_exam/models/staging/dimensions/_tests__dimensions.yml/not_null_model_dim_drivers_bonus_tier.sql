
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select bonus_tier
from "ae_exam_db"."main"."model_dim_drivers"
where bonus_tier is null



  
  
      
    ) dbt_internal_test