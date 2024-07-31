DROP DATABASE IF EXISTS js; 
-- Create JS DB
CREATE DATABASE js
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


-- create extension dblink;
SET search_path TO public;
SELECT dblink_connect('js-conn', 'dbname=js password=postgres' );

-- Create JS Schema
SELECT dblink_exec('js-conn', 
'
    CREATE SCHEMA "jobs-service"
        AUTHORIZATION postgres;
    SET SEARCH_PATH="jobs-service";
    CREATE TABLE JSMyTable2 (
        MyColumn VARCHAR(100) NOT NULL
    );
');