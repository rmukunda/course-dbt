{{
	config(materialized='view')
	}}

select 
	count(session_id) as total_sessions,
	count(session_id) filter (where page_view>0) as page_view_sessions,
	count(session_id) filter (where add_to_cart>0) as add_to_cart_sessions,
	count(session_id) filter (where checkout>0) as checkout_sessions,
	count(session_id) filter (where package_shipped >0) as package_shipped_sessions
from {{ref('int_session_metrics')}} m

