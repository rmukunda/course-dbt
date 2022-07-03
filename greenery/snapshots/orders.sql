{% snapshot orders_snapshot %}

{{

    config( target_schema = 'snapshots',
            target_database = 'dbt',
            unique_key = 'order_id',
            
            strategy= 'check',
            check_cols=['status'])
}}

select *
from {{source('greenery_source','orders')}}

{% endsnapshot %}