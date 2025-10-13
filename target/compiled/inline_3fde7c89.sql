select * from (
with customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from dbt-tutorial.jaffle_shop.customers

)
SELECT * FROM customers
) as __preview_sbq__ limit 1000