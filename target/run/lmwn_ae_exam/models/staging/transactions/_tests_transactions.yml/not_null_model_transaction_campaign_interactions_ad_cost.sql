
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ad_cost
from "ae_exam_db"."main"."model_transaction_campaign_interactions"
where ad_cost is null



  
  
      
    ) dbt_internal_test