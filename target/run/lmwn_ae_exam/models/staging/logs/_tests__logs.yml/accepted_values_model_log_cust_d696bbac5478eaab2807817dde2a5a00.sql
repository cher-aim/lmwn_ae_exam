
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        device_type as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_log_customer_app_sessions"
    group by device_type

)

select *
from all_values
where value_field not in (
    'web','ios','android'
)



  
  
      
    ) dbt_internal_test