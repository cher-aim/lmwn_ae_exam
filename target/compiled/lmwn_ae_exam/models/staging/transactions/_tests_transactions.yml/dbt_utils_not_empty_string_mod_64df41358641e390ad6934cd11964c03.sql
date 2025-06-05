

    with
    
    all_values as (

        select 


            trim(customer_id) as customer_id
            
        from "ae_exam_db"."main"."model_transaction_campaign_interactions"

    ),

    errors as (

        select * from all_values
        where customer_id = ''

    )

    select * from errors

