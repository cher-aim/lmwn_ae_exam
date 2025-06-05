



select
    1
from "ae_exam_db"."main"."model_transaction_support_tickets"

where not(csat_score BETWEEN 0 AND 5)

