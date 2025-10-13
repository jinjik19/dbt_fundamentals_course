select * from (
with customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from dbt-tutorial.jaffle_shop.customers

),

orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from dbt-tutorial.jaffle_shop.orders

)
SELECT * FROM orders
) as __preview_sbq__ limit 1000