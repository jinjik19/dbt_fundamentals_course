SELECT
    order_id,
    SUM(amount) as total_amount
FROM {{ref('stg_stripe__payments')}}
GROUP BY order_id
HAVING total_amount < 0