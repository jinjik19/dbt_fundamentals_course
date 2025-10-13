with customers as (
    select * from {{ ref('stg_laffle_shop__customers') }}
),

orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

payment as (
    select * 
    from {{ ref('stg_stripe__payments') }}
    where status = 'success'
),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

customer_orders_pairs as (
    
    select
        customer_id,
        order_id
    from orders
),

customer_payments as (
    select
        sum(payment.amount) / 100 as lifetime_value

    from payment
    left join customer_orders_pairs using (order_id)

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        (select lifetime_value from customer_payments) as lifetime_value

    from customers

    left join customer_orders using (customer_id)

)

select * from final
