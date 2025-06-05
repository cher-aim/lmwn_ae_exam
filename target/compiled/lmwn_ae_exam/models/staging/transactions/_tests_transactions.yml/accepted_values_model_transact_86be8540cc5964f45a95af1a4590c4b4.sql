
    
    

with all_values as (

    select
        issue_sub_type as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_transaction_support_tickets"
    group by issue_sub_type

)

select *
from all_values
where value_field not in (
    'refund','cold','not_delivered','rude','overcharged','wrong_item','late','no_mask'
)


