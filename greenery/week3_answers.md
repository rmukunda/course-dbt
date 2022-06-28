## Week3 Project Questions

### Sample of Questions that can be answered with facts or intermediate models.

<br>

> What is our overall conversion rate?

```
select round((count(distinct session_id ) filter (where checkout >0))  * 1.0/count(distinct session_id ),4) *100 as overall_conversion_rate_percent
from dbt_mukunda_r.int_session_metrics ism 

```

> What is our conversion rate by product?

```
select  fpem.product_id , dp.product_name ,  round(((product_sessions_with_checkouts * 1.0) / total_user_sessions),2) as conversion_rate 
from dbt_mukunda_r.fct_product_event_metrics fpem join dbt_mukunda_r.dim_products dp on dp.product_id = fpem.product_id 

```
