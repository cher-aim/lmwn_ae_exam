
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        payment_method as value_field,
        count(*) as n_records

    from "ae_exam_db"."main"."model_transaction_orders"
    group by payment_method

)

select *
from all_values
where value_field not in (
    'cash','mobile_wallet','credit_card'
)



  
  
      
    ) dbt_internal_test