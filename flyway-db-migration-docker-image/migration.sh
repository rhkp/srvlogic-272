#!/bin/bash
mkdir /flyway/sql

#echo LISTING ROOT DIR
#ls /
#
#echo LISTING SQL DIR
#ls /flyway/sql
#
#echo LISTING JARS
#ls /flyway/jars

echo PASSED PARAMS
echo $1 $2 $3 $4

if [ "$1" == "DI" ]
then
    echo "Migrating DI database"
    cp /di-db-migration-files/*.sql /flyway/sql
else
    echo "Migrating JS database"
    cp /js-db-migration-files/*.sql /flyway/sql
fi

flyway -url="$2" -user="$3" -password="$4" migrate
flyway -url="$2" -user="$3" -password="$4" info