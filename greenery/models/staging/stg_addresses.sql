{{
    config(
    materialized='view'
  )
}}

select
	address_id,
	address,
	zipcode,
	state,
	country
from {{source('greenery_source','addresses')}}