-- Use the `ref` function to select from other models

select *
from "ae_exam_db"."main"."my_first_dbt_model"
where id = 1