{{
    config(materialized='table')
    }}


select
	se.session_id ,
	max(se.order_id) order_id ,
	max(se.product_id) product_id ,
	max(user_id) user_id,
	count(event_id ) as session_events,
	count(1 ) filter( where event_type = 'add_to_cart') as add_to_cart,
	count(1 ) filter( where event_type = 'checkout') as checkout,
	count(1 ) filter( where event_type = 'page_view') as page_view,
	count(1 ) filter( where event_type = 'package_shipped') as package_shipped
from
	{{ref("stg_events")}} se
group by
	1
