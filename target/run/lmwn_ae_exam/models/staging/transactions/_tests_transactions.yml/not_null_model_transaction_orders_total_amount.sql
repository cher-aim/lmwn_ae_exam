
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_amount
from "ae_exam_db"."main"."model_transaction_orders"
where total_amount is null



  
  
      
    ) dbt_internal_test