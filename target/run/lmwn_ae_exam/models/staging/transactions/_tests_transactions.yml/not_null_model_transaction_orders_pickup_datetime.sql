
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select pickup_datetime
from "ae_exam_db"."main"."model_transaction_orders"
where pickup_datetime is null



  
  
      
    ) dbt_internal_test