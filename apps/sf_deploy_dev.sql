--------------------------------------------------------------------------------------------
--  SCRIPT:    Code from this script updates objects in Snowflake DEV account.
--             
--             
--
--   YY-MM-DD WHO          CHANGE DESCRIPTION
--   -------- ------------ -----------------------------------------------------------------

--------------------------------------------------------------------------------------------

-- TABLES
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/dev/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/bronze/tables/Customer.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/dev/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/bronze/tables/Orders.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/dev/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/bronze/tables/Product.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/dev/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/tables/Customer.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/dev/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/tables/Orders.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/dev/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/tables/Product.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/dev/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/gold/tables/Shipping.sql;
 
-- VIEWS
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/dev/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/bronze/views/Customer_Orders.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/dev/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/views/Customer_Orders.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/dev/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/views/Product_Inventory.sql;

-- PROCEDURES
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/dev/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/bronze/storedProcedures/Load_Bronze_Customer_Orders.sql;