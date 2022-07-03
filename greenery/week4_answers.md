## Week4 Project

### Product funnel analysis.

<br>

> What is a query against a model which can help with product funnel analysis?

```
select total_sessions, page_view_sessions, add_to_cart_sessions, checkout_sessions, package_shipped_sessions 
from public.fct_session_counts fsc ;

```

#### Users end up buying in about 62.5% (361 out of 578) of sessions. Users add to cart on 80% (467 out of 578) of the sessions. Of the 467 sessions where they add a product to cart, they actually buy 77% of time (361 sessions).