
    
    

select
    customer_id as unique_field,
    count(*) as n_records

from "ae_exam_db"."main"."model_dim_customers"
where customer_id is not null
group by customer_id
having count(*) > 1


