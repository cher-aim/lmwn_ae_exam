
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

    with
    
    all_values as (

        select 


            trim(campaign_id) as campaign_id
            
        from "ae_exam_db"."main"."model_transaction_campaign_interactions"

    ),

    errors as (

        select * from all_values
        where campaign_id = ''

    )

    select * from errors


  
  
      
    ) dbt_internal_test