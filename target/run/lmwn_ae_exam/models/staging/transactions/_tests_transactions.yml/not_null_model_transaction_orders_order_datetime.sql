
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_datetime
from "ae_exam_db"."main"."model_transaction_orders"
where order_datetime is null



  
  
      
    ) dbt_internal_test