
    
    

with all_values as (

    select
        device_type as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_transaction_campaign_interactions"
    group by device_type

)

select *
from all_values
where value_field not in (
    'ios','web','android'
)


