---------------------------------------------------------------------------------------------
--  SCRIPT:    Initial Environment Creation Script

--   -- Desc:
--   --        This script is run manually to create the following objects:
--   --
--   --        Admin Control database ADM_CONTROL_DB
--   --        ADM_CONTROL_DB.DEPLOY schema is where the following objects will be created:
--   --        GITHUB_SECRET, GITHUB_API_INTEGRATION & SNOWFLAKE_GIT_REPO
--   --        This script also initializes roles and role hierarchies to support
--   --        our basic RBAC & Security model.
--   --        Also creates ADM_CONTROL_DB_WH, the warehouse dedicated to ADM_CONTROL_DB.
--   --        
--   -- Execution Options:
--   --         snow sql -f "./apps/01_manual_account_setup.sql"; 
--   --         snow sql -f "./apps/02_git_integration.sql";
--   --         Above requires Snowflake CLI to be installed locally first. See:
--   --         04_snowflake_cli_setup.md on how to do that.
--   --
--   -- Or you can simply:
--   --         Copy/Paste THIS ENTIRE script into a Worksheet in a Snowflake Trial Account 
--   --         and run manually! No other setups required.
--   -- 
--   --         NOTE> This script is intended to be idempotent with the use 
--   --         of 'CREATE [object] IF NOT EXISTS' statments.
--   -- 
--   YY-MM-DD WHO          CHANGE DESCRIPTION
--   -------- ------------ -----------------------------------------------------------------

---------------------------------------------------------------------------------------------
SET beNm = 'fin';        -- Business Entity / Segment
SET dbNm = 'sales';    -- Database Name
SET scNm = 'bronze';     -- Schema Name

-- construct the database name and delegated admin role
SET prefixNm = $beNm;
SET dbNm = $prefixNm || '_' || $dbNm;                                                
SET databaseNm = $dbNm || '_DB';
SET schemaNm = $databaseNm || '.' || $scNm;
SET publicSchemaNm = $databaseNm || '.' || 'public';
SET pltfrAdmin  = 'PDE_SYSADMIN_FR';  --- Platform sysadmin,  delegated role granted up to SYSADMIN. Create only once.

SET localfrAdmin  =  $dbNm || '_SYSADMIN_FR';
set pltfrTagAdmin = 'PDE_TAGADMIN_FR';  -- Currently, creation of tags are reserved for PDE_TAGADMIN_FR as a security measure.
                                        -- However, if we decide to change this just grant PDE_TAGADMIN_FR to another role like this:
                                        -- USE ROLE USERADMIN;
                                        -- GRANT ROLE PDE_TAGADMIN_FR TO ROLE MYDATAENGINEERROLE;

-- construct the 3 Access Role SCHEMA LEVEL, for Read, Write & Create
SET sarR =  $dbNm || '_' || $scNm || '_R_AR';  -- READ access role
SET sarW =  $dbNm || '_' || $scNm || '_RW_AR';  -- WRITE access role
SET sarC =  $dbNm || '_' || $scNm || '_FULL_AR';  -- CREATE or FULL access role

SET whNm  = $databaseNm || '_WH';
SET whComment = 'Warehouse for ' || $databaseNm ;   -- comments for warehouse

    
-- construct the 2 Access Role names for Usage and Operate
SET warU = $whNm || '_WU_AR';  -- Monitor & Usage
SET warO = $whNm || '_WO_AR';  -- Operate & Modify (so WH can be resized operationally if needed)


-- USE SCHEMA ADM_CONTROL_DB.DEPLOY;

-- EXECUTE IMMEDIATE FROM @SNOWFLAKE_GIT_REPO/branches/master/apps/build_schema.sql;