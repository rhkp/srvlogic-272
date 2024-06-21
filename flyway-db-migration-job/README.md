# Migrate database in OpenShift Cluster using flyway-image

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

## Deploy and Run DB Migration Job
* In the terminal window of developer machine, use the following command to start DB migration job.
```shell
oc apply -f flyway-image-db-migration-job.yaml
```
* In OpenShift console, navigate to Workloads->Pods->flyway-image-job Pod->Logs
* You should see an output similar to the following
```text
+-----------+---------+------------------+--------------+---------------------+----------+----------+
| Category | Version | Description | Type | Installed On | State | Undoable |
+-----------+---------+------------------+--------------+---------------------+----------+----------+
| Baseline | 1.0.0 | di create schema | SQL_BASELINE | 2024-06-21 19:19:04 | Baseline | No |
| Versioned | 1.0.1 | di mytable | SQL | 2024-06-21 19:19:04 | Success | No |
| Versioned | 1.0.2 | di mytable2 | SQL | 2024-06-21 19:19:04 | Success | No |
| Versioned | 1.0.3 | js mytable | SQL | 2024-06-21 19:19:04 | Success | No |
| Versioned | 1.0.4 | js mytable2 | SQL | 2024-06-21 19:19:04 | Success | No |
+-----------+---------+------------------+--------------+---------------------+----------+----------+
```
* Also, once the job completes, Workloads->Pods->flyway-image-job should show a green tick besides it, signifying successful completion. 

## Uninstall Resources
```shell
oc delete ns aswf
```

