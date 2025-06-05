
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_id
from "ae_exam_db"."main"."model_transaction_orders"
where order_id is null



  
  
      
    ) dbt_internal_test