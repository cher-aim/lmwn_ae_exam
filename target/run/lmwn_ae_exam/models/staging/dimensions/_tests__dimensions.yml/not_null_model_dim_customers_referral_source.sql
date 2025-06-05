
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select referral_source
from "ae_exam_db"."main"."model_dim_customers"
where referral_source is null



  
  
      
    ) dbt_internal_test