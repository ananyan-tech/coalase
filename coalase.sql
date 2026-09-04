

-- Create the database
CREATE DATABASE IF NOT EXISTS PC_COALESCE_DB;

-- Set context to the new database
USE DATABASE PC_COALESCE_DB;

-- Create the schema
CREATE SCHEMA IF NOT EXISTS PUBLIC;

-- Set context to the new schema
USE SCHEMA PUBLIC;

-- Create customers table
CREATE TABLE IF NOT EXISTS RAW_customers (
    cust_id     NUMBER        PRIMARY KEY,
    cust_name   VARCHAR(100),
    phone       VARCHAR(20)
);

-- Create products table
CREATE TABLE IF NOT EXISTS RAW_products (
    prod_id     NUMBER        PRIMARY KEY,
    prod_name   VARCHAR(100)
);

-- Create orders table
CREATE TABLE IF NOT EXISTS RAW_orders (
    order_id    NUMBER        PRIMARY KEY,
    cust_id     NUMBER        REFERENCES coalase.coalse_sch.customers(cust_id),
    prod_id     NUMBER        REFERENCES coalase.coalse_sch.products(prod_id),
    unit        NUMBER,
    cost        NUMBER(10,2)
);

-- Populate customers table (8 records)
INSERT INTO RAW_customers (cust_id, cust_name, phone) VALUES
(1, 'Rahul Sharma', '9876543210'),
(2, 'Priya Menon', '9123456780'),
(3, 'amit Verma', '9988776655'),
(4, 'Sneha Iyer', '9871234560'),
(5, 'Karan Malhotra', '9012345678'),
(6, 'divya Nair', '9765432109'),
(7, 'Vikram Singh', '9345678901'),
(8, 'Ananya Rao', '9456789012');

-- Populate products table (6 records)
INSERT INTO RAW_products (prod_id, prod_name) VALUES
(101, 'Laptop'),
(102, 'Wireless Mouse'),
(103, 'Mechanical Keyboard'),
(104, 'Monitor 24-inch'),
(105, 'USB-C Hub'),
(106, 'Noise Cancelling Headphones');

-- Populate orders table (10 records)
INSERT INTO RAW_orders (order_id, cust_id, prod_id, unit, cost) VALUES
(1001, 1, 101, 1, 55000.00),
(1002, 2, 102, 2, 1200.00),
(1003, 3, 103, 1, 3500.00),
(1004, 4, 104, 1, 9000.00),
(1005, 5, 105, 3, 4500.00),
(1006, 6, 106, 1, 6500.00),
(1007, 1, 102, 1, 600.00),
(1008, 7, 101, 1, 58000.00),
(1009, 8, 104, 2, 18000.00),
(1010, 3, 106, 1, 6500.00);

USE ROLE ACCOUNTADMIN;  -- or a role that has GRANT privileges (e.g., SECURITYADMIN / owner role)

-- Grant usage on database and schema (required to access anything inside)
GRANT USAGE ON DATABASE PC_COALESCE_DB TO ROLE PC_COALESCE_ROLE;
GRANT USAGE ON SCHEMA PC_COALESCE_DB.PUBLIC TO ROLE PC_COALESCE_ROLE;

-- Grant read + write (SELECT, INSERT, UPDATE, DELETE, TRUNCATE) on all EXISTING tables
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA PC_COALESCE_DB.PUBLIC TO ROLE PC_COALESCE_ROLE;

-- Grant SELECT on all EXISTING views (views are read-only by nature)
GRANT SELECT ON ALL VIEWS IN SCHEMA PC_COALESCE_DB.PUBLIC TO ROLE PC_COALESCE_ROLE;

-- Ensure the role gets the same privileges on any FUTURE tables/views created in this schema
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON FUTURE TABLES IN SCHEMA PC_COALESCE_DB.PUBLIC TO ROLE PC_COALESCE_ROLE;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA PC_COALESCE_DB.PUBLIC TO ROLE PC_COALESCE_ROLE;
