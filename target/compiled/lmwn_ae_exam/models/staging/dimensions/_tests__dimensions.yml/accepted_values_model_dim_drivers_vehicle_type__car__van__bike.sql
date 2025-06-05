
    
    

with all_values as (

    select
        vehicle_type as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_dim_drivers"
    group by vehicle_type

)

select *
from all_values
where value_field not in (
    'car','van','bike'
)


