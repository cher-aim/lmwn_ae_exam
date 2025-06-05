
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        bonus_tier as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_dim_drivers"
    group by bonus_tier

)

select *
from all_values
where value_field not in (
    'bronze','silver','gold','platinum'
)



  
  
      
    ) dbt_internal_test