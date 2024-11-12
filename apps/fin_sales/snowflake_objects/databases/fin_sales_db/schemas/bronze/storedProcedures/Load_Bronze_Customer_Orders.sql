CREATE OR REPLACE PROCEDURE LOAD_BRONZE_CUSTOMER_ORDERS()
RETURNS STRING
LANGUAGE JAVASCRIPT
AS
$$
try {
    var sql_command = `CREATE TABLE Bronze_Customer_Orders AS
                       SELECT c.C_CUSTKEY,
                              c.C_NAME AS customer_name,
                              o.O_ORDERKEY,
                              o.O_ORDERSTATUS,
                              C_PHONE
                       FROM Customer c
                       JOIN Orders o ON c.C_CUSTKEY = o.O_CUSTKEY`;

    var stmt = snowflake.createStatement({sqlText: sql_command});
    stmt.execute();
    
    return 'Bronze_Customer_Orders table created successfully.';
} catch (err) {
    return err.message;
}
$$;