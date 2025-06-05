
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "ae_exam_db"."main"."model_dim_restaurants"

where not(restaurant_id LIKE 'REST%')


  
  
      
    ) dbt_internal_test