
    
    

with all_values as (

    select
        event_type as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_transaction_campaign_interactions"
    group by event_type

)

select *
from all_values
where value_field not in (
    'impression','click','conversion'
)


