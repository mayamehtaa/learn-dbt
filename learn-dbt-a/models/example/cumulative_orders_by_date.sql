{{ config(materialized='table') }}

WITH CTE1 AS (
SELECT
    o_orderdate,
    SUM(o_totalprice) AS total_order_price
FROM snowflake_sample_data.tpch_sf1.orders
GROUP BY o_orderdate
ORDER BY o_orderdate
)

SELECT
    o_orderdate,
    total_order_price,
    SUM(total_order_price) OVER (ORDER BY o_orderdate) AS cumulative_sales
FROM CTE1
ORDER BY o_orderdate
