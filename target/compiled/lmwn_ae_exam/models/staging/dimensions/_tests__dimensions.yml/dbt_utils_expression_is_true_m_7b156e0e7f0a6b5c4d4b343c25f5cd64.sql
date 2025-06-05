



select
    1
from "ae_exam_db"."main"."model_dim_restaurants"

where not(restaurant_id LIKE 'REST%')

