
    
    

with all_values as (

    select
        region as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_log_driver_incentive"
    group by region

)

select *
from all_values
where value_field not in (
    'central','north','south','metro','east'
)


