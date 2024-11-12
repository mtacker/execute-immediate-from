create 
or replace view fin_sales_db.silver.customer_orders as 
(
   select
      c_name,
      c_address,
      c_phone,
      O_ORDERSTATUS,
      O_TOTALPRICE,
      O_ORDERDATE 
   from
      fin_sales_db.bronze.Customer 
      left outer join
         fin_sales_db.bronze.Orders 
         on C_CUSTKEY = O_CUSTKEY 
)
limit 100;














-- CREATE OR REPLACE VIEW fin_sales_db.silver.Customer_Orders AS
-- SELECT
--     c.customer_id,
--     c.name AS customer_name,
--     o.order_id,
--     o.product_id,
--     o.quantity
-- FROM
--     Customer c
-- JOIN
--     Orders o ON c.customer_id = o.customer_id;