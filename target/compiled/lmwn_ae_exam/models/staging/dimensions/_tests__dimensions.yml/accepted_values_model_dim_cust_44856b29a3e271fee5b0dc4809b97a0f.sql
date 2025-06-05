
    
    

with all_values as (

    select
        preferred_device as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_dim_customers"
    group by preferred_device

)

select *
from all_values
where value_field not in (
    'ios','android','web'
)


