{{
	config(materialized='table')
	}}

with user_orders as
(
	select
		su.user_id,
		count(so.order_id) as total_orders,
		sum(case when so.promo_id is not null then 1 else 0 end) as discounted_orders,
		round(sum(so.order_total)::decimal, 2) total_spend,
		round((sum(so.order_total)/ count(order_id))::decimal,2) as per_order_spend ,
		min(so.created_at) as first_order_date ,
		max(so.created_at) as last_order_date
	from
		{{ref("stg_users")}} su
	inner join {{ref("stg_orders")}} so on
		su.user_id = so.user_id
	group by
		su.user_id
	order by
		1
)
,
user_product_orders as 
(
	select
		su.user_id ,
		count(distinct soi.product_id ) distinct_products_ordered,
		sum(soi.quantity) as total_ordered_products
	from
		{{ref("stg_users")}} su
	join {{ref("stg_orders")}} so on
		su.user_id = so.user_id
	join {{ref("stg_order_items")}} soi on
		so.order_id = soi.order_id
	group by
		su.user_id
)

select
	u.user_id,
	total_orders,
	discounted_orders,
	total_spend,
	per_order_spend,
	first_order_date,
	last_order_date,
	distinct_products_ordered,
	total_ordered_products
from
	user_orders u
left join user_product_orders u1 on
	u.user_id = u1.user_id