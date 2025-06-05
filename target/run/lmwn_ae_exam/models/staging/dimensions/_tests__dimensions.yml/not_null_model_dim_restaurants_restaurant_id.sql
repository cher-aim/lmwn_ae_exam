
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select restaurant_id
from "ae_exam_db"."main"."model_dim_restaurants"
where restaurant_id is null



  
  
      
    ) dbt_internal_test