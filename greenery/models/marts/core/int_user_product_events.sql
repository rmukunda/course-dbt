{{
    config(materialized='table')
    }}



with session_buys as 	
(
	select
		session_id , 	
		user_id,	
		order_id ,
		checkout ,
		package_shipped 
	from
		{{ref("int_session_metrics")}}  

),
product_sesions as 
	(
	select
		se.session_id ,
		product_id ,
		count(event_id) as session_events,
		count(event_type) filter(
		where
			event_type = 'add_to_cart'
		) as add_to_cart,
		count(event_type) filter(
		where
			event_type = 'page_view'
		) as page_view
	from
		{{ref("stg_events")}} se
	group by
		1,2
)
,
final_ as
(
	select
		sb.session_id,
		sb.order_id,
		ps.product_id,
		sb.user_id,
		ps.session_events,
		ps.add_to_cart,
		ps.page_view,
		sb.checkout,
		sb.package_shipped
	from
		session_buys sb
	left join product_sesions ps on
		sb.session_id = ps.session_id
	where ps.product_id is not null 
)

select
	*
from
	final_