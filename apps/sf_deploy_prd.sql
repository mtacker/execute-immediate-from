--------------------------------------------------------------------------------------------
--  SCRIPT:    Code from this script updates objects in Snowflake production account.
--             
--             
--
--   YY-MM-DD WHO          CHANGE DESCRIPTION
--   -------- ------------ -----------------------------------------------------------------

--------------------------------------------------------------------------------------------

-- SCHEMAS     

-- --------------------------------------------------------------------------------------------
-- -- Approach 1 - Include SET variables WITH the build code  
-- EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/adm_control/snowflake_objects/databases/adm_control_db/schemas/tags/tags_build.sql;
-- -- Results in error:
-- -- "Unsupported feature 'session variables not supported during object dependencies backfill"
-- EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/adm_control/snowflake_objects/databases/adm_control_db/schemas/alerts/alerts_build.sql;
-- --------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
-- Approach 2 - Separate SET variables FROM the build code
--------------------------------------------------------------------------------------------
-- tags.sql SUCCEEDS
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/adm_control/snowflake_objects/databases/adm_control_db/schemas/alerts/alerts.sql;


-- Alerts.sql FAILS with:
--
-- Uncaught exception of  │
-- │ type 'STATEMENT_ERROR' in file                                               │
-- │ @SNOWFLAKE_GIT_REPO/branches/master/apps/sf_deploy_prd.sql on line 36 at     │
-- │ position 0:                                                                  │
-- │ Cannot perform operation. This session does not have a current database.     │
-- │ Call 'USE DATABASE', or use a qualified name.   
-- *******************************************************************************
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/adm_control/snowflake_objects/databases/adm_control_db/schemas/tags/tags.sql;
--------------------------------------------------------------------------------------------





-- The rest of my proposed orchestration would look like this:

-- TABLES
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/bronze/tables/Customer.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/bronze/tables/Orders.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/bronze/tables/Product.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/tables/Customer.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/tables/Orders.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/tables/Product.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/gold/tables/Shipping.sql;
 
-- VIEWS
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/bronze/views/Customer_Orders.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/views/Customer_Orders.sql;
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/silver/views/Product_Inventory.sql;

-- PROCEDURES
EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/fin_sales/snowflake_objects/databases/fin_sales_db/schemas/bronze/storedProcedures/Load_Bronze_Customer_Orders.sql;
