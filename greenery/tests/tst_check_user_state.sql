select *
from {{ref('dim_users')}}
where country = 'United States'
    and state not in (select state from {{source('greenery_source','addresses')}})