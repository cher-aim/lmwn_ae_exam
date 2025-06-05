
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select log_id
from "ae_exam_db"."main"."model_log_order_status"
where log_id is null



  
  
      
    ) dbt_internal_test