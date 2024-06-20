# Migrate database in OpenShift Cluster using flyway-mage

## Issue description
[SRVLOGIC-272: Persistency and schema initialization handling](https://issues.redhat.com/browse/SRVLOGIC-272)

## Prerequisites
* Running OpenShift 4.15 cluster
* Working oc command on developer machine

## Deploy the Postgres Service
* Run the following command in a terminal
```shell
oc create namespace aswf
oc project aswf

# Create username and password secrets for the Postgres DB
oc create secret generic postgres-secrets --from-literal=POSTGRES_USER=your-db-user --from-literal=POSTGRES_PASSWORD=your-db-password --from-literal=POSTGRES_DB=sonataflow --from-literal=PGDATA=/var/lib/postgresql/data/mydata

oc apply -f pg.yaml
```
* Once the postgres pod is available, in the OpenShift console's Admin view, navigate to Workloads->Pods->Postgres->Terminal
* In the Postgres terminal use following commands to create di-db and js-db databases, before migration job can be run.
```shell
psql -U your-db-user -d postgres

# Following two lines are to be executed on postgres prompt in psql application
postgres=# CREATE DATABASE "di-db";
postgres=# CREATE DATABASE "js-db"
```

## Deploy and Run DB Migration Job
* In the terminal window of developer machine, use the following command to start DB migration job.
```shell
oc apply -f flyway-image-db-migration-job.yaml
```
* In OpenShift console, navigate to Workloads->Pods->flyway-image-job Pod->Logs
* You should see an output similar to the following
```text
+-----------+---------+-------------+------+---------------------+---------+----------+
| Category | Version | Description | Type | Installed On | State | Undoable |
+-----------+---------+-------------+------+---------------------+---------+----------+
| Versioned | 1.0.0 | di mytable | SQL | 2024-06-20 17:56:30 | Success | No |
| Versioned | 1.0.1 | di mytable2 | SQL | 2024-06-20 17:56:30 | Success | No |
+-----------+---------+-------------+------+---------------------+---------+----------+
```

## Uninstall Resources
```shell
oc delete ns aswf
```

