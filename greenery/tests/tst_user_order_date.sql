select *
from {{ref('fct_user_order_metrics')}}
where first_order_date > last_order_date