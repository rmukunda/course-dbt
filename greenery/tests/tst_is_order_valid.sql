select *
from {{ref('int_user_product_events')}}
where order_id is null 
        and (checkout+package_shipped>0)