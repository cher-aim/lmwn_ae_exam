
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select incentive_program
from "ae_exam_db"."main"."model_log_driver_incentive"
where incentive_program is null



  
  
      
    ) dbt_internal_test