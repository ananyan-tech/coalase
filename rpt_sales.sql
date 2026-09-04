USE DATABASE PC_COALESCE_DB;
USE SCHEMA PUBLIC;

CREATE OR REPLACE VIEW RPT_SALES AS
SELECT
    prod_name,
    cust_name,
    SUM(unit)                  AS total_units_sold,
    SUM(cost)                  AS total_sales,
    COUNT(DISTINCT order_id)   AS total_orders
FROM FCT_ORDERS
GROUP BY prod_name, cust_name
ORDER BY total_sales DESC;

SELECT * FROM RPT_SALES;