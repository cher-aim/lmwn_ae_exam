
    
    

with all_values as (

    select
        status as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_log_support_ticket_status"
    group by status

)

select *
from all_values
where value_field not in (
    'opened','resolved'
)


