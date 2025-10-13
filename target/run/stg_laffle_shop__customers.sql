

  create or replace view `jaffle-shop-474903`.`raw`.`stg_laffle_shop__customers`
  OPTIONS()
  as select
    id as customer_id,
    first_name,
    last_name

from dbt-tutorial.jaffle_shop.customers;

