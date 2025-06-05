

    with
    
    all_values as (

        select 


            trim(order_id) as order_id
            
        from "ae_exam_db"."main"."model_transaction_campaign_interactions"

    ),

    errors as (

        select * from all_values
        where order_id = ''

    )

    select * from errors

