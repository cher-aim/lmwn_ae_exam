



select
    1
from "ae_exam_db"."main"."model_dim_customers"

where not(customer_id LIKE 'CUST%')

