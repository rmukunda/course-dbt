{{
    config(
    materialized='view'
  )
}}


select
	order_id,
	product_id,
	quantity
from {{source('greenery_source','order_items')}}