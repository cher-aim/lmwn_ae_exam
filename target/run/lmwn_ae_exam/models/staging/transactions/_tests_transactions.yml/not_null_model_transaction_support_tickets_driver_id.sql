
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select driver_id
from "ae_exam_db"."main"."model_transaction_support_tickets"
where driver_id is null



  
  
      
    ) dbt_internal_test