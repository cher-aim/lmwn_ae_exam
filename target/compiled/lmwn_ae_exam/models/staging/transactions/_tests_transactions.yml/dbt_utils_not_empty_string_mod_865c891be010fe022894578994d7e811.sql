

    with
    
    all_values as (

        select 


            trim(ticket_id) as ticket_id
            
        from "ae_exam_db"."main"."model_transaction_support_tickets"

    ),

    errors as (

        select * from all_values
        where ticket_id = ''

    )

    select * from errors

