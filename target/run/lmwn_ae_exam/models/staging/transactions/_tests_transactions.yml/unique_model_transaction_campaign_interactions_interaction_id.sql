
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    interaction_id as unique_field,
    count(*) as n_records

from "ae_exam_db"."main"."model_transaction_campaign_interactions"
where interaction_id is not null
group by interaction_id
having count(*) > 1



  
  
      
    ) dbt_internal_test