#!/bin/bash

echo PASSED PARAMS
echo $1 $2 $3

cp /db-migration-files/*.sql /sql

echo LISTING SQL DIR
ls /sql

flyway -url="$1" -user="$2" -password="$3" -mixed="true" -locations="filesystem:/sql" -schemas="public,data-index-service,jobs-service"  migrate
flyway -url="$1" -user="$2" -password="$3" -mixed="true" -locations="filesystem:/sql" -schemas="public,data-index-service,jobs-service" info