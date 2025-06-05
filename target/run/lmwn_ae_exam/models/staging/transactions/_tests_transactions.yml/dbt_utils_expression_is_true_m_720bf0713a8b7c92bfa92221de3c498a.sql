
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "ae_exam_db"."main"."model_transaction_campaign_interactions"

where not(CASE 
  WHEN event_type = 'conversion' 
  THEN order_id IS NOT NULL AND revenue > 0
  ELSE true
END)


  
  
      
    ) dbt_internal_test