
    
    

select
    log_id as unique_field,
    count(*) as n_records

from "ae_exam_db"."main"."model_log_support_ticket_status"
where log_id is not null
group by log_id
having count(*) > 1


