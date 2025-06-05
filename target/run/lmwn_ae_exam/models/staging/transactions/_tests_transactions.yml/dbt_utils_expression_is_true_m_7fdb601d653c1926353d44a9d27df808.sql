
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "ae_exam_db"."main"."model_transaction_support_tickets"

where not(ticket_id LIKE 'TKT%')


  
  
      
    ) dbt_internal_test