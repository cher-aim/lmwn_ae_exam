

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

