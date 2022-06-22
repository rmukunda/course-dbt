select *
from {{ref('fct_product_event_metrics')}}
where 1=1
    and product_sessions_with_shipment > product_sessions_with_checkouts