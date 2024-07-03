# Migrate database in OpenShift Cluster using flyway-image

## Issue description
[SRVLOGIC-272: Persistency and schema initialization handling](https://issues.redhat.com/browse/SRVLOGIC-272)

## Prerequisites
* Running OpenShift 4.15 cluster
* Working oc command on developer machine
* The flyway image has been made ready for use and available. Please checkout [this](../cekit-approach-ubi9-flyway-db-migration-docker-image/README.md).

## Deploy and Run the DB Migration Job including Postgres Service
* Run the following command in a terminal
```shell
./exec-db-migration-job.sh
```
* In OpenShift console, navigate to Workloads->Pods->flyway-image-job Pod->Logs
* You should see an output similar to the following
```text
+-----------+----------+------------------------------------+--------+---------------------+---------+----------+
| Category | Version | Description | Type | Installed On | State | Undoable |
+-----------+----------+------------------------------------+--------+---------------------+---------+----------+
| | | << Flyway Schema Creation >> | SCHEMA | 2024-06-27 19:19:14 | Success | |
| Versioned | 1.0.1 | di mytable | SQL | 2024-06-27 19:19:14 | Success | No |
| Versioned | 1.0.2 | di mytable2 | SQL | 2024-06-27 19:19:14 | Success | No |
| Versioned | 1.0.3 | js mytable2 | SQL | 2024-06-27 19:19:14 | Success | No |
| Versioned | 1.0.4 | js mytable | SQL | 2024-06-27 19:19:14 | Success | No |
| Versioned | 1.32.0 | data index create | SQL | 2024-06-27 19:19:15 | Success | No |
| Versioned | 1.44.0 | data index definitions | SQL | 2024-06-27 19:19:16 | Success | No |
| Versioned | 1.45.0.0 | data index node definitions | SQL | 2024-06-27 19:19:16 | Success | No |
| Versioned | 1.45.0.1 | add identity to process instance | SQL | 2024-06-27 19:19:17 | Success | No |
| Versioned | 1.45.0.2 | data index definitions add columns | SQL | 2024-06-27 19:19:17 | Success | No |
| Versioned | 1.45.0.3 | add fk index | SQL | 2024-06-27 19:19:17 | Success | No |
| Versioned | 1.45.0.4 | increase varchar length | SQL | 2024-06-27 19:19:18 | Success | No |
| Versioned | 2.0.0 | Create Table | SQL | 2024-06-27 19:19:18 | Success | No |
| Versioned | 2.0.1 | job details increase job id size | SQL | 2024-06-27 19:19:18 | Success | No |
| Versioned | 2.0.2 | job details add fire time col | SQL | 2024-06-27 19:19:18 | Success | No |
| Versioned | 2.0.3 | Create Table Management | SQL | 2024-06-27 19:19:19 | Success | No |
| Versioned | 3.0.0 | Create Jobs Table V2 | SQL | 2024-06-27 19:19:19 | Success | No |
| Versioned | 3.0.1 | Migrate Jobs v1 to v2 Table | SQL | 2024-06-27 19:19:19 | Success | No |
| Versioned | 3.0.2 | Add Execution Timeout Col | SQL | 2024-06-27 19:19:19 | Success | No |
| Versioned | 3.0.3 | Add Created Col | SQL | 2024-06-27 19:19:19 | Success | No |
+-----------+----------+------------------------------------+--------+---------------------+---------+----------+
```
* Also, once the job completes, Workloads->Pods->flyway-image-job should show a green tick besides it, signifying successful completion. 

## Uninstall Resources
```shell
oc delete ns aswf
```