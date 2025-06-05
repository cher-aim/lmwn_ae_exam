
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

    with
    
    all_values as (

        select 


            trim(name) as name
            
        from "ae_exam_db"."main"."model_dim_restaurants"

    ),

    errors as (

        select * from all_values
        where name = ''

    )

    select * from errors


  
  
      
    ) dbt_internal_test