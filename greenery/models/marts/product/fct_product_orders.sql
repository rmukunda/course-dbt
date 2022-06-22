{{
    config(materialized='table')
    }}

with product_orders as
(
	select
		sp.product_id ,
		sp."name" product,
		sum(soi.quantity) as total_ordered_products,
		round(avg(soi.quantity)::decimal, 2) as average_quantity_ordered,
		count(distinct so.order_id ) as number_of_orders,
		count(distinct so.user_id ) as buying_users,
		round((sum((soi.quantity * sp.price)))::decimal, 2) as amount_spent,
		round(sum(so.order_cost)::decimal, 2) as total_order_cost_amount
	from
		 {{ref("stg_orders")}} so
	join {{ref("stg_order_items")}} soi on
		so.order_id = soi.order_id
	join {{ref("stg_products")}} sp on
		sp.product_id = soi.product_id
	group by
		sp.product_id ,
		sp."name"
)
		
select
	*,
	ceil (
		(
			(
				amount_spent / total_order_cost_amount
			) * 100
		)
	) as product_order_share
from
	product_orders    