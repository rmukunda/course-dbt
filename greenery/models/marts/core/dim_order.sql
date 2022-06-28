{{
    config(materialized='table')
    }}
select so.order_id , so.user_id , 
	promo_id , address_id, created_at , shipping_service , status 
from {{ref('stg_orders')}} so
