
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "ae_exam_db"."main"."model_log_driver_incentive"

where not(bonus_amount > 0)


  
  
      
    ) dbt_internal_test