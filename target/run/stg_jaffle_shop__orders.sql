

  create or replace view `jaffle-shop-474903`.`raw`.`stg_jaffle_shop__orders`
  OPTIONS()
  as select
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
    _etl_loaded_at

from dbt-tutorial.jaffle_shop.orders;

