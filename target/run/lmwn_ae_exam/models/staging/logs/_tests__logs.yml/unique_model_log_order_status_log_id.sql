
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    log_id as unique_field,
    count(*) as n_records

from "ae_exam_db"."main"."model_log_order_status"
where log_id is not null
group by log_id
having count(*) > 1



  
  
      
    ) dbt_internal_test