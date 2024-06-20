#!/bin/bash

echo PASSED PARAMS
echo $1 $2 $3 $4

if [ "$1" == "DI" ]
then
    echo "Migrating DI database"
    cp /di-db-migration-files/*.sql /sql
else
    echo "Migrating JS database"
    cp /js-db-migration-files/*.sql /sql
fi

echo LISTING SQL DIR
ls /sql

flyway -url="$2" -user="$3" -password="$4" -locations="filesystem:/sql" migrate
flyway -url="$2" -user="$3" -password="$4" -locations="filesystem:/sql" info