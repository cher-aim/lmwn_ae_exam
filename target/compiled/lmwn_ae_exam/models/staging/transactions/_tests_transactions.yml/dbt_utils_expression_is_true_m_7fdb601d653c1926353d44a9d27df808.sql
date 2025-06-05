



select
    1
from "ae_exam_db"."main"."model_transaction_support_tickets"

where not(ticket_id LIKE 'TKT%')

