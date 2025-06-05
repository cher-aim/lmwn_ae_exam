
    
    

with all_values as (

    select
        delivery_zone as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_transaction_orders"
    group by delivery_zone

)

select *
from all_values
where value_field not in (
    'east','south','central','north'
)


