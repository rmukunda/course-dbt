select *
from {{ref('fct_user_event_metrics')}}
where 1=1
    and user_sessions_with_shipment > user_sessions_with_checkouts