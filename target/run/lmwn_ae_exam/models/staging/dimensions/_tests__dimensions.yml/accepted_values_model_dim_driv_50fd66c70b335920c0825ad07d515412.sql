
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        region as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_dim_drivers"
    group by region

)

select *
from all_values
where value_field not in (
    'east','north','central','south','metro'
)



  
  
      
    ) dbt_internal_test