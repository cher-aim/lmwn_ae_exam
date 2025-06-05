
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "ae_exam_db"."main"."model_transaction_campaign_interactions"

where not(ad_cost >= 0)


  
  
      
    ) dbt_internal_test