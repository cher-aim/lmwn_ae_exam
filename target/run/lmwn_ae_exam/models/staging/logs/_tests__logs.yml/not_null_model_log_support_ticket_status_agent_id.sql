
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select agent_id
from "ae_exam_db"."main"."model_log_support_ticket_status"
where agent_id is null



  
  
      
    ) dbt_internal_test