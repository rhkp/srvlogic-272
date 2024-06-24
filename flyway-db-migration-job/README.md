# Migrate database in OpenShift Cluster using flyway-image

## Issue description
[SRVLOGIC-272: Persistency and schema initialization handling](https://issues.redhat.com/browse/SRVLOGIC-272)

## Prerequisites
* Running OpenShift 4.15 cluster
* Working oc command on developer machine

## Deploy and Run the DB Migration Job including Postgres Service
* Run the following command in a terminal
```shell
./exec-db-migration-job.sh
```
* In OpenShift console, navigate to Workloads->Pods->flyway-image-job Pod->Logs
* You should see an output similar to the following
```text
+-----------+---------+------------------------------+--------+---------------------+---------+----------+
| Category | Version | Description | Type | Installed On | State | Undoable |
+-----------+---------+------------------------------+--------+---------------------+---------+----------+
| | | << Flyway Schema Creation >> | SCHEMA | 2024-06-24 15:32:27 | Success | |
| Versioned | 1.0.1 | di mytable | SQL | 2024-06-24 15:32:27 | Success | No |
| Versioned | 1.0.2 | di mytable2 | SQL | 2024-06-24 15:32:27 | Success | No |
| Versioned | 1.0.3 | js mytable2 | SQL | 2024-06-24 15:32:27 | Success | No |
| Versioned | 1.0.4 | js mytable | SQL | 2024-06-24 15:32:27 | Success | No |
+-----------+---------+------------------------------+--------+---------------------+---------+----------+
```
* Also, once the job completes, Workloads->Pods->flyway-image-job should show a green tick besides it, signifying successful completion. 

## Uninstall Resources
```shell
oc delete ns aswf
```