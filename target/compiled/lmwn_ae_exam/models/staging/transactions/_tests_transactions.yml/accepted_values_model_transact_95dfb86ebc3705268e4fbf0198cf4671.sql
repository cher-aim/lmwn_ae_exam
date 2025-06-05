
    
    

with all_values as (

    select
        channel as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_transaction_support_tickets"
    group by channel

)

select *
from all_values
where value_field not in (
    'email','call','in_app'
)


