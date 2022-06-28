{{
	config(materialized='table')
}}

{% set event_types = dbt_utils.get_column_values(table=ref('stg_events'), column='event_type') %}

with session_event_metrics
as 
(select
	se.session_id ,
	max(se.order_id) order_id ,
	count(distinct se.product_id) filter(where product_id is not null) products ,
	max(user_id) user_id,
	count(event_id ) as session_events
	{% for event in event_types %}
		, count(1 ) filter( where event_type = '{{event}}') as {{event}}
	{% endfor %}
/*	
	count(1 ) filter( where event_type = 'add_to_cart') as add_to_cart,
	count(1 ) filter( where event_type = 'checkout') as checkout,
	count(1 ) filter( where event_type = 'page_view') as page_view,
	count(1 ) filter( where event_type = 'package_shipped') as package_shipped
*/	
from
	{{ref('stg_events')}} se
group by 
	1)
select * from session_event_metrics 