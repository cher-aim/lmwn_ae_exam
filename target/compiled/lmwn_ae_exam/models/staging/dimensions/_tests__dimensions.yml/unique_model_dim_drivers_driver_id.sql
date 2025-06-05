
    
    

select
    driver_id as unique_field,
    count(*) as n_records

from "ae_exam_db"."main"."model_dim_drivers"
where driver_id is not null
group by driver_id
having count(*) > 1


