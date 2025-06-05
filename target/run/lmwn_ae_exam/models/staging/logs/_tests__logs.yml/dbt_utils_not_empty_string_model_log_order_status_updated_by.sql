
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

    with
    
    all_values as (

        select 


            trim(updated_by) as updated_by
            
        from "ae_exam_db"."main"."model_log_order_status"

    ),

    errors as (

        select * from all_values
        where updated_by = ''

    )

    select * from errors


  
  
      
    ) dbt_internal_test