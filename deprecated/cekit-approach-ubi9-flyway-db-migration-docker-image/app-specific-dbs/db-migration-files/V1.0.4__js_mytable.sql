SELECT dblink_exec('js-conn', 
'
    SET SEARCH_PATH="jobs-service";
    CREATE TABLE JSMyTable (
        MyColumn VARCHAR(100) NOT NULL
    );
');

SELECT dblink_disconnect('js-conn');