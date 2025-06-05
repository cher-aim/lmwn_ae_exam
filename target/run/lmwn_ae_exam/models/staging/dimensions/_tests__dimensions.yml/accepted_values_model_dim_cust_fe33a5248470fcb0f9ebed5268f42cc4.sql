
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        referral_source as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_dim_customers"
    group by referral_source

)

select *
from all_values
where value_field not in (
    'ads','social','friend','search','campaign'
)



  
  
      
    ) dbt_internal_test