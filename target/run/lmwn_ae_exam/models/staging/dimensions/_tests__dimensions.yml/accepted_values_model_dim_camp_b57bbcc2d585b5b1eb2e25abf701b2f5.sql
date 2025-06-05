
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        campaign_type as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_dim_campaigns"
    group by campaign_type

)

select *
from all_values
where value_field not in (
    'retargeting','seasonal','loyalty','acquisition'
)



  
  
      
    ) dbt_internal_test