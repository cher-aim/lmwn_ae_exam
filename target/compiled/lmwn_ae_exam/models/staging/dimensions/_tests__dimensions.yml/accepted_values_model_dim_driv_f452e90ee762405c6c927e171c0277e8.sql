
    
    

with all_values as (

    select
        active_status as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_dim_drivers"
    group by active_status

)

select *
from all_values
where value_field not in (
    'inactive','active'
)


