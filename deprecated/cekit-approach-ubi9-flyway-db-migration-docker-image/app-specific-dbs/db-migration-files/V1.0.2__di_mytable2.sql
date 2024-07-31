SELECT dblink_exec('di-conn', 
'
    SET SEARCH_PATH="data-index-service";
    CREATE TABLE DIMyTable2 (
        MyColumn VARCHAR(100) NOT NULL
    );
');

SELECT dblink_disconnect('di-conn');