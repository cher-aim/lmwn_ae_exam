
    
    

with all_values as (

    select
        platform as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_transaction_campaign_interactions"
    group by platform

)

select *
from all_values
where value_field not in (
    'google','facebook','tiktok'
)


