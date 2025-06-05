
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        category as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_dim_restaurants"
    group by category

)

select *
from all_values
where value_field not in (
    'Vegan','Western','Japanese','Coffee','Fast Food','Bakery','Thai'
)



  
  
      
    ) dbt_internal_test