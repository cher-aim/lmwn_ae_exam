
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select revenue
from "ae_exam_db"."main"."model_transaction_campaign_interactions"
where revenue is null



  
  
      
    ) dbt_internal_test