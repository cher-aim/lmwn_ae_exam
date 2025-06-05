



select
    1
from "ae_exam_db"."main"."model_transaction_orders"

where not(pickup_datetime >= order_datetime)

