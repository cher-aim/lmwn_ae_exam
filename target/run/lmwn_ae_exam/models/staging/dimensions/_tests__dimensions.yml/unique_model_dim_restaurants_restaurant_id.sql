
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    restaurant_id as unique_field,
    count(*) as n_records

from "ae_exam_db"."main"."model_dim_restaurants"
where restaurant_id is not null
group by restaurant_id
having count(*) > 1



  
  
      
    ) dbt_internal_test