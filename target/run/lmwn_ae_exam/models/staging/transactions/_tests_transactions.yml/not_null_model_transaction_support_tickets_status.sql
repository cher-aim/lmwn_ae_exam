
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select status
from "ae_exam_db"."main"."model_transaction_support_tickets"
where status is null



  
  
      
    ) dbt_internal_test