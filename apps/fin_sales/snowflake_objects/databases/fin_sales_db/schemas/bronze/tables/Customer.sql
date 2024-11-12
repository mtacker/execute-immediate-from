-- Joining Customer and Orders in a View at:
-- apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/views/Customer_Orders.sql
-- https://app.snowflake.com/iqiqvjq/qeb39663/#/data/databases/FIN_SALES_DB/schemas/SILVER/view/CUSTOMER_ORDERS/data-preview

-----------------------------------------------------------------------
-- Source Table:
-- SNOWFLAKE_SAMPLE_DATA.TPCH_SF10.CUSTOMER contains 1,500,000 records
DROP TABLE IF EXISTS fin_sales_db.bronze.Customer;

CREATE OR ALTER TABLE fin_sales_db.bronze.Customer (
	C_CUSTKEY NUMBER(38,0),
	C_NAME VARCHAR(25),
	C_ADDRESS VARCHAR(40),
	C_NATIONKEY NUMBER(38,0),
	C_PHONE VARCHAR(15)
);

INSERT INTO fin_sales_db.bronze.CUSTOMER (
    C_CUSTKEY, 
    C_NAME, 
    C_ADDRESS, 
    C_NATIONKEY, 
    C_PHONE)
  SELECT 
    C_CUSTKEY, 
    C_NAME, 
    C_ADDRESS, 
    C_NATIONKEY, 
    C_PHONE 
  FROM 
    SNOWFLAKE_SAMPLE_DATA.TPCH_SF10.CUSTOMER;

select count(*) from SNOWFLAKE_SAMPLE_DATA.TPCH_SF10.CUSTOMER;