
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select interaction_datetime
from "ae_exam_db"."main"."model_transaction_campaign_interactions"
where interaction_datetime is null



  
  
      
    ) dbt_internal_test