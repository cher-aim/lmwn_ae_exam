
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        incentive_program as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_log_driver_incentive"
    group by incentive_program

)

select *
from all_values
where value_field not in (
    'weekly_bonus','rainy_day','holiday_special'
)



  
  
      
    ) dbt_internal_test