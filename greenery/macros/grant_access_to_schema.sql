{% macro grant_access_to_schema (role) %}
    grant usage on schema {{ target.schema }} to group {{role}};
    grant select on all tables in schema {{ target.schema }} to  {{role}};
{% endmacro %}
