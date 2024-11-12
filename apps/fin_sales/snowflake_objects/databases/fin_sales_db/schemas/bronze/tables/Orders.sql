-- Joining Customer and Orders in a View at:
-- apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/views/Customer_Orders.sql
-- https://app.snowflake.com/iqiqvjq/qeb39663/#/data/databases/FIN_SALES_DB/schemas/SILVER/view/CUSTOMER_ORDERS/data-preview

-----------------------------------------------------------------------
-- Source Table:
-- SNOWFLAKE_SAMPLE_DATA.TPCH_SF10.ORDERS contains 15,000,000 records
DROP TABLE IF EXISTS fin_sales_db.bronze.Orders;
CREATE OR ALTER TABLE fin_sales_db.bronze.Orders (
	O_ORDERKEY NUMBER(38,0),
	O_CUSTKEY NUMBER(38,0),
	O_ORDERSTATUS VARCHAR(1),
	O_TOTALPRICE NUMBER(12,2),
	O_ORDERDATE DATE,
	O_ORDERPRIORITY VARCHAR(15),
	O_CLERK VARCHAR(15),
	O_SHIPPRIORITY NUMBER(38,0),
	O_COMMENT VARCHAR(79)
);
INSERT INTO fin_sales_db.bronze.ORDERS (
    O_ORDERKEY, 
    O_CUSTKEY, 
    O_ORDERSTATUS, 
    O_TOTALPRICE, 
    O_ORDERDATE, 
    O_ORDERPRIORITY, 
    O_CLERK, 
    O_SHIPPRIORITY, 
    O_COMMENT)
  SELECT 
    O_ORDERKEY, 
    O_CUSTKEY, 
    O_ORDERSTATUS, 
    O_TOTALPRICE, 
    O_ORDERDATE, 
    O_ORDERPRIORITY, 
    O_CLERK, 
    O_SHIPPRIORITY, 
    O_COMMENT 
  FROM 
    SNOWFLAKE_SAMPLE_DATA.TPCH_SF10.ORDERS;

