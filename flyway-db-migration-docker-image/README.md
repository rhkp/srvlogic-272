# DB Migration Podman Image using Flyway

## Issue description
[SRVLOGIC-272: Persistency and schema initialization handling](https://issues.redhat.com/browse/SRVLOGIC-272)

## Prerequisites
* Running Podman command and Podman Desktop
* Postgres database running and accessible with available credentials

## Build the DB Migration Image
* Run the following command in a terminal
```shell
./build-container-image.sh
```
* The image can be executed with the command of the form
```shell
podman run flyway-image <component> <url> <your-db-user> <your-db-password>

# component: DI for data index or JS for job service
# url: jdbc:postgresql:<server>:<port>/<db> e.g. jdbc:postgresql://host.docker.internal:5432/js-db
```

## Create databases in Postgres Server
* Create two databases on the Postgres DB server: `di-db` for data index and `js-db` for jobs service.

## Run the DB Migration Image - DI
* Migrate the data index database using following command
```shell
podman run flyway-image DI jdbc:postgresql://host.docker.internal:5432/di-db <your-db-user> <your-db-password>
```
* You should see output, which contains the following
```text
+-----------+---------+-------------+------+---------------------+---------+----------+
| Category  | Version | Description | Type | Installed On        | State   | Undoable |
+-----------+---------+-------------+------+---------------------+---------+----------+
| Versioned | 1.0.0   | di mytable  | SQL  | 2024-06-19 19:41:49 | Success | No       |
| Versioned | 1.0.1   | di mytable2 | SQL  | 2024-06-19 19:41:50 | Success | No       |
+-----------+---------+-------------+------+---------------------+---------+----------+
```
* Verify the database indeed has the tables shown above.

## Run the DB Migration Image - JS
* Migrate the job service database using following command
```shell
podman run flyway-image JS jdbc:postgresql://host.docker.internal:5432/js-db <your-db-user> <your-db-password>
```
* You should see output, which contains the following
```text
+-----------+---------+-------------+------+---------------------+---------+----------+
| Category  | Version | Description | Type | Installed On        | State   | Undoable |
+-----------+---------+-------------+------+---------------------+---------+----------+
| Versioned | 1.0.0   | js mytable  | SQL  | 2024-06-19 19:40:40 | Success | No       |
| Versioned | 1.0.1   | js mytable2 | SQL  | 2024-06-19 19:40:40 | Success | No       |
+-----------+---------+-------------+------+---------------------+---------+----------+
```
* Verify the database indeed has the tables shown above.