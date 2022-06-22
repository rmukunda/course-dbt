{{
    config(materialized='table')
    }}

select
	su.user_id ,
	su.first_name ,
	su.last_name ,
	sa.state ,
	sa.country ,
	sa.zipcode
from
	{{ref("stg_users")}} su
join {{ref("stg_addresses")}} sa on
	sa.address_id = su.address_id