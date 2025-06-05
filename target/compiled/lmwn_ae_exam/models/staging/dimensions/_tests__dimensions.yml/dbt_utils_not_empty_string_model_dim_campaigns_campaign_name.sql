

    with
    
    all_values as (

        select 


            trim(campaign_name) as campaign_name
            
        from "ae_exam_db"."main"."model_dim_campaigns"

    ),

    errors as (

        select * from all_values
        where campaign_name = ''

    )

    select * from errors

