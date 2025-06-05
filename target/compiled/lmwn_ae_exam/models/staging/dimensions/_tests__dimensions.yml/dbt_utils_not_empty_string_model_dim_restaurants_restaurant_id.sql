

    with
    
    all_values as (

        select 


            trim(restaurant_id) as restaurant_id
            
        from "ae_exam_db"."main"."model_dim_restaurants"

    ),

    errors as (

        select * from all_values
        where restaurant_id = ''

    )

    select * from errors

