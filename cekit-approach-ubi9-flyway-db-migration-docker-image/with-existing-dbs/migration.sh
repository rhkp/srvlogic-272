#!/bin/bash

echo USING ENV VARS
echo URL=$DB_URL USER=$DB_USER PWD=$DB_PWD

if [ -z "$DATA_INDEX_SCHEMA" ]; then
    DATA_INDEX_SCHEMA=data-index-service
    echo "Using the data index schema: $DATA_INDEX_SCHEMA"
fi

if [ -z "$JOBS_SERVICE_SCHEMA" ]; then
    JOBS_SERVICE_SCHEMA=jobs-service
    echo "Using the jobs service schema: $JOBS_SERVICE_SCHEMA"
fi

# Update $DATA_INDEX_SCHEMA for data index sql files
cd /home/default/db-migration-files/data-index
for FILE in *; do sed -i.bak 's/$DATA_INDEX_SCHEMA/'$DATA_INDEX_SCHEMA'/' $FILE; done
rm -rf *.bak

# Update $JOBS_SERVICE_SCHEMA for jobs service sql files
cd /home/default/db-migration-files/jobs-service
for FILE in *; do sed -i.bak 's/$JOBS_SERVICE_SCHEMA/'$JOBS_SERVICE_SCHEMA'/' $FILE; done
rm -rf *.bak

echo LISTING SQL DIR: DATA-INDEX
ls /home/default/db-migration-files/data-index

echo LISTING SQL DIR: JOBS-SERVICE
ls /home/default/db-migration-files/jobs-service

/home/default/flyway/flyway -url="$DB_URL" -user="$DB_USER" -password="$DB_PWD" -mixed="true" -locations="filesystem:/home/default/db-migration-files" -schemas="public,$DATA_INDEX_SCHEMA,$JOBS_SERVICE_SCHEMA"  migrate
/home/default/flyway/flyway -url="$DB_URL" -user="$DB_USER" -password="$DB_PWD" -mixed="true" -locations="filesystem:/home/default/db-migration-files" -schemas="public,$DATA_INDEX_SCHEMA,$JOBS_SERVICE_SCHEMA" info