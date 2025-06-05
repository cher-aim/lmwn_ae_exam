



select
    1
from "ae_exam_db"."main"."model_log_customer_app_sessions"

where not(session_start < session_end)

