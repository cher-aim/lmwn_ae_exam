
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select session_start
from "ae_exam_db"."main"."model_log_customer_app_sessions"
where session_start is null



  
  
      
    ) dbt_internal_test