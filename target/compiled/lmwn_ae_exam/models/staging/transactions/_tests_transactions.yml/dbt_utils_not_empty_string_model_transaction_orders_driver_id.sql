

    with
    
    all_values as (

        select 


            trim(driver_id) as driver_id
            
        from "ae_exam_db"."main"."model_transaction_orders"

    ),

    errors as (

        select * from all_values
        where driver_id = ''

    )

    select * from errors

