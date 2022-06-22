{% test non_zero(model, column_name) %}

   select *
   from {{ model }}
   where {{ column_name }} < 1

{% endtest %}