



select
    1
from "ae_exam_db"."main"."model_dim_drivers"

where not(driver_rating BETWEEN 0.0 AND 5.0)

