



select
    1
from "ae_exam_db"."main"."model_dim_campaigns"

where not(campaign_id LIKE 'CMP%')

