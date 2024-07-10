-- Create DI DB
CREATE DATABASE di
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

create extension dblink;
SET search_path TO public;
SELECT dblink_connect('di-conn', 'dbname=di password=postgres' );

-- Create DI Schema
SELECT dblink_exec('di-conn', 
'
    CREATE SCHEMA "data-index-service"
        AUTHORIZATION postgres;
    SET SEARCH_PATH="data-index-service";
    CREATE TABLE DIMyTable (
        MyColumn VARCHAR(100) NOT NULL
    );
');

