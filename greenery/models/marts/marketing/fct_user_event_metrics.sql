{{
	config(materialized='table')
	}}

with user_session_stats as
(select
	iupe.user_id ,
	count(distinct session_id) total_user_sessions,
	count(distinct product_id ) total_unique_products_sampled,
	sum(session_events) total_user_session_events,
	count(distinct session_id ) filter (where checkout > 0) as user_sessions_with_checkouts,
	count(distinct session_id ) filter (where package_shipped > 0) as user_sessions_with_shipment,
	count(distinct session_id ) filter (where add_to_cart > 0) as user_sessions_with_add_to_cart,
	sum(add_to_cart) as total_add_to_cart,
	sum(page_view) as total_page_views,
	sum(checkout ) filter (where product_id is null) as total_checkouts,
	sum(package_shipped ) filter (where product_id is null) as total_shipments
	
from
	{{ref('int_user_product_events')}} iupe
group by
	iupe.user_id)
	
	select * from user_session_stats 
