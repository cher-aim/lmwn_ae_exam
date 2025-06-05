
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "ae_exam_db"."main"."model_transaction_orders"

where not(order_id LIKE 'ORD%')


  
  
      
    ) dbt_internal_test