{{
    config(materialized='table')
    }}


select
	product_id,
	"name" as product_name,
	price
from
	{{ref("stg_products")}} sp 	
