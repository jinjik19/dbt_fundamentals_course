-- created_at: 2025-10-13T06:00:37.584276+00:00
-- finished_at: 2025-10-13T06:00:42.501247+00:00
-- outcome: success
-- dialect: bigquery
-- node_id: not available
-- query_id: not available
-- desc: execute adapter call
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","connection_name":""} */

    select distinct schema_name from `jaffle-shop-474903`.INFORMATION_SCHEMA.SCHEMATA;
  ;
-- created_at: 2025-10-13T06:00:43.989915+00:00
-- finished_at: 2025-10-13T06:00:47.621356+00:00
-- outcome: success
-- dialect: bigquery
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: not available
-- desc: get_relation > list_relations call
SELECT
    table_catalog,
    table_schema,
    table_name,
    table_type
FROM 
    `jaffle-shop-474903`.`raw`.INFORMATION_SCHEMA.TABLES;
-- created_at: 2025-10-13T06:00:43.988606+00:00
-- finished_at: 2025-10-13T06:00:48.857232+00:00
-- outcome: success
-- dialect: bigquery
-- node_id: model.jaffle_shop.stg_laffle_shop__customers
-- query_id: not available
-- desc: get_relation > list_relations call
SELECT
    table_catalog,
    table_schema,
    table_name,
    table_type
FROM 
    `jaffle-shop-474903`.`raw`.INFORMATION_SCHEMA.TABLES;
-- created_at: 2025-10-13T06:00:47.629244+00:00
-- finished_at: 2025-10-13T06:00:50.218098+00:00
-- outcome: success
-- dialect: bigquery
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: not available
-- desc: execute adapter call
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.stg_jaffle_shop__orders"} */


  create or replace view `jaffle-shop-474903`.`raw`.`stg_jaffle_shop__orders`
  OPTIONS()
  as select
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
    _etl_loaded_at

from dbt-tutorial.jaffle_shop.orders;

;
-- created_at: 2025-10-13T06:00:48.860151+00:00
-- finished_at: 2025-10-13T06:00:51.453525+00:00
-- outcome: success
-- dialect: bigquery
-- node_id: model.jaffle_shop.stg_laffle_shop__customers
-- query_id: not available
-- desc: execute adapter call
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.stg_laffle_shop__customers"} */


  create or replace view `jaffle-shop-474903`.`raw`.`stg_laffle_shop__customers`
  OPTIONS()
  as select
    id as customer_id,
    first_name,
    last_name

from dbt-tutorial.jaffle_shop.customers;

;
-- created_at: 2025-10-13T06:00:51.456669+00:00
-- finished_at: 2025-10-13T06:00:56.317933+00:00
-- outcome: success
-- dialect: bigquery
-- node_id: model.jaffle_shop.dim_customers
-- query_id: not available
-- desc: execute adapter call
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.dim_customers"} */

  
    

    create or replace table `jaffle-shop-474903`.`raw`.`dim_customers`
      
    
    

    OPTIONS()
    as (
      with customers as (
    select * from `jaffle-shop-474903`.`raw`.`stg_laffle_shop__customers`
),

orders as (
    select * from `jaffle-shop-474903`.`raw`.`stg_jaffle_shop__orders`
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


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final
    );
  ;
