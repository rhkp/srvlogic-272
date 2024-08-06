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
__  ____  __  _____   ___  __ ____  ______ 
 --/ __ \/ / / / _ | / _ \/ //_/ / / / __/ 
 -/ /_/ / /_/ / __ |/ , _/ ,< / /_/ /\ \   
--\___\_\____/_/ |_/_/|_/_/|_|\____/___/   
2024-08-06 18:53:43,439 INFO  [io.quarkus] (main) sonataflow-db-migrator 1.0-SNAPSHOT on JVM (powered by Quarkus 3.13.0) started in 3.406s. 
2024-08-06 18:53:43,447 INFO  [io.quarkus] (main) Profile prod activated. 
2024-08-06 18:53:43,447 INFO  [io.quarkus] (main) Installed features: [agroal, cdi, flyway, jdbc-postgresql, narayana-jta, smallrye-context-propagation]
Checking migration...
2024-08-06 18:53:44,974 INFO  [org.fly.cor.FlywayExecutor] (main) Database: jdbc:postgresql://postgres:5432/sonataflow (PostgreSQL 13.2)
2024-08-06 18:53:45,129 INFO  [org.fly.cor.int.sch.JdbcTableSchemaHistory] (main) Schema history table "public"."flyway_schema_history" does not exist yet
2024-08-06 18:53:45,138 INFO  [org.fly.cor.int.com.cle.CleanExecutor] (main) Successfully dropped pre-schema database level objects (execution time 00:00.003s)
2024-08-06 18:53:45,177 INFO  [org.fly.cor.int.com.cle.CleanExecutor] (main) Successfully cleaned schema "public" (execution time 00:00.034s)
2024-08-06 18:53:45,195 INFO  [org.fly.cor.int.com.cle.CleanExecutor] (main) Successfully cleaned schema "public" (execution time 00:00.016s)
2024-08-06 18:53:45,206 INFO  [org.fly.cor.int.com.cle.CleanExecutor] (main) Successfully dropped post-schema database level objects (execution time 00:00.008s)
2024-08-06 18:53:45,402 INFO  [org.fly.cor.int.sch.JdbcTableSchemaHistory] (main) Schema history table "public"."flyway_schema_history" does not exist yet
2024-08-06 18:53:45,421 INFO  [org.fly.cor.int.com.DbValidate] (main) Successfully validated 15 migrations (execution time 00:00.119s)
2024-08-06 18:53:45,461 INFO  [org.fly.cor.int.sch.JdbcTableSchemaHistory] (main) Creating Schema History table "public"."flyway_schema_history" ...
2024-08-06 18:53:45,704 INFO  [org.fly.cor.int.com.DbMigrate] (main) Current version of schema "public": << Empty Schema >>
2024-08-06 18:53:45,919 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "1.32.0 - data index create"
2024-08-06 18:53:46,222 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_attachments_tasks" of relation "attachments" does not exist, skipping
2024-08-06 18:53:46,226 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_comments_tasks" of relation "comments" does not exist, skipping
2024-08-06 18:53:46,229 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_milestones_process" of relation "milestones" does not exist, skipping
2024-08-06 18:53:46,231 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_nodes_process" of relation "nodes" does not exist, skipping
2024-08-06 18:53:46,234 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_processes_addons_processes" of relation "processes_addons" does not exist, skipping
2024-08-06 18:53:46,237 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_processes_roles_processes" of relation "processes_roles" does not exist, skipping
2024-08-06 18:53:46,240 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_tasks_admin_groups_tasks" of relation "tasks_admin_groups" does not exist, skipping
2024-08-06 18:53:46,242 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_tasks_admin_users_tasks" of relation "tasks_admin_users" does not exist, skipping
2024-08-06 18:53:46,245 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_tasks_excluded_users_tasks" of relation "tasks_excluded_users" does not exist, skipping
2024-08-06 18:53:46,247 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_tasks_potential_groups_tasks" of relation "tasks_potential_groups" does not exist, skipping
2024-08-06 18:53:46,252 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_tasks_potential_users_tasks" of relation "tasks_potential_users" does not exist, skipping
2024-08-06 18:53:46,384 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "1.44.0 - data index definitions"
2024-08-06 18:53:46,450 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_definitions_addons_definitions" of relation "definitions_addons" does not exist, skipping
2024-08-06 18:53:46,453 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_definitions_roles_definitions" of relation "definitions_roles" does not exist, skipping
2024-08-06 18:53:46,491 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "1.45.0.0 - data index node definitions"
2024-08-06 18:53:46,540 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_definitions_nodes_definitions" of relation "definitions_nodes" does not exist, skipping
2024-08-06 18:53:46,544 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_definitions_nodes_metadata_definitions_nodes" of relation "definitions_nodes_metadata" does not exist, skipping
2024-08-06 18:53:46,586 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "1.45.0.1 - add identity to process instance"
2024-08-06 18:53:46,629 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "1.45.0.2 - data index definitions add columns"
2024-08-06 18:53:46,671 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_definitions_annotations" of relation "definitions_annotations" does not exist, skipping
2024-08-06 18:53:46,675 INFO  [org.fly.cor.int.sql.DefaultSqlScriptExecutor] (main) DB: constraint "fk_definitions_metadata" of relation "definitions_metadata" does not exist, skipping
2024-08-06 18:53:46,734 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "1.45.0.3 - add fk index"
2024-08-06 18:53:46,963 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "1.45.0.4 - increase varchar length"
2024-08-06 18:53:46,996 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "2.0.0 - Create Table"
2024-08-06 18:53:47,063 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "2.0.1 - job details increase job id size"
2024-08-06 18:53:47,087 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "2.0.2 - job details add fire time col"
2024-08-06 18:53:47,122 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "2.0.3 - Create Table Management"
2024-08-06 18:53:47,174 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "3.0.0 - Create Jobs Table V2"
2024-08-06 18:53:47,246 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "3.0.1 - Migrate Jobs v1 to v2 Table"
2024-08-06 18:53:47,285 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "3.0.2 - Add Execution Timeout Col"
2024-08-06 18:53:47,333 INFO  [org.fly.cor.int.com.DbMigrate] (main) Migrating schema "public" to version "3.0.3 - Add Created Col"
2024-08-06 18:53:47,407 INFO  [org.fly.cor.int.com.DbMigrate] (main) Successfully applied 15 migrations to schema "public", now at version v3.0.3 (execution time 00:00.901s)
3.0.3
2024-08-06 18:53:47,558 INFO  [io.quarkus] (Shutdown thread) sonataflow-db-migrator stopped in 0.049s
```
* Also, once the job completes, Workloads->Pods->flyway-image-job should show a green tick besides it, signifying successful completion. 

## Uninstall Resources
```shell
oc delete ns aswf
```