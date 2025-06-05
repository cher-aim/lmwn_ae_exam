
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select payment_method
from "ae_exam_db"."main"."model_transaction_orders"
where payment_method is null



  
  
      
    ) dbt_internal_test