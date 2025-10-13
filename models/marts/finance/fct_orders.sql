with payment as (
    select * from {{ ref('stg_stripe__payments') }}
),
customer_orders as (

    select
        customer_id,
        order_id
    from {{ ref('stg_jaffle_shop__orders') }}

),
final as (
    select
        payment.order_id,
        customer_orders.customer_id,
        payment.amount
    from payment
    left join customer_orders using (order_id)
)

select * from final
