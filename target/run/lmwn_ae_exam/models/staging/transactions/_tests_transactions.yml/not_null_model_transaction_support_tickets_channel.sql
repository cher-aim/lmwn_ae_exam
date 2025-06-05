
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select channel
from "ae_exam_db"."main"."model_transaction_support_tickets"
where channel is null



  
  
      
    ) dbt_internal_test