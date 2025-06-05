
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select issue_sub_type
from "ae_exam_db"."main"."model_transaction_support_tickets"
where issue_sub_type is null



  
  
      
    ) dbt_internal_test