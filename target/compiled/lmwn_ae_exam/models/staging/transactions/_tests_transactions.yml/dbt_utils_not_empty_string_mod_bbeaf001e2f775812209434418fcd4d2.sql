

    with
    
    all_values as (

        select 


            trim(interaction_id) as interaction_id
            
        from "ae_exam_db"."main"."model_transaction_campaign_interactions"

    ),

    errors as (

        select * from all_values
        where interaction_id = ''

    )

    select * from errors

