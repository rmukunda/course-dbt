{{config(materialized='view')}}

with dates as
({{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2022-01-01' as date)",
    end_date="cast(now() as date)"
   )
}})

select * from dates