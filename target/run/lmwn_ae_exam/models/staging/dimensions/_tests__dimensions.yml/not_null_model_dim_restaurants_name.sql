
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select name
from "ae_exam_db"."main"."model_dim_restaurants"
where name is null



  
  
      
    ) dbt_internal_test