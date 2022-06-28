{{
    config(materialized='table')
}}

with order_products as 
(
	select
		soi.order_id ,
		count(product_id) as unique_products_ordered,
		sum(soi.quantity) product_quantity
	from
		{{ref('stg_order_items')}} soi
	group by
		soi.order_id
),
orders as 
(
	select
		so.order_id ,
		created_at 
		,
		case
			when promo_id is not null then true
			else false
		end as has_promo
		,
		case
			when (
				delivered_at > estimated_delivery_at
				and status = 'delivered'
			) then 'late'
			when (
				delivered_at < estimated_delivery_at
				and status = 'delivered'
			) then 'early'
			when (
				delivered_at = estimated_delivery_at
				and status = 'delivered'
			) then 'on-time'
			else 'N/A'
		end as delivery_status
		,
		status 
		,
		(
			date_part('epoch', estimated_delivery_at ) - date_part('epoch', delivered_at )
		)/ 3600 delivery_estimate_difference
		,
		so.order_total 
		,
		so.shipping_cost 
		,
		so.order_cost
	from
		{{ref('stg_orders')}} so
)


select
	o.order_id ,
	o.created_at ,
	o.has_promo,
	o.delivery_status ,
		o.delivery_estimate_difference ,
	o.order_cost ,
	o.shipping_cost ,
	o.order_total ,
		op.unique_products_ordered ,
	op.product_quantity
from
	orders o
left join order_products op on
	o.order_id = op.order_id
