# Deprecated - DB Migration Podman Image using Flyway
This version of Flyway DB migration image is deprecated as it does not make use of Red Hat official ubi9 image.
Instead please visit [ubi9 based flyway image](../ubi9-flyway-db-migration-docker-image/README.md).

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
podman run flyway-image <url> <your-db-user> <your-db-password>

# url: jdbc:postgresql:<server>:<port>/<db> e.g. jdbc:postgresql://host.docker.internal:5432/sonataflow
```

## Create databases in Postgres Server
* Create a database on the Postgres DB server with name: `sonataflow`.

## Run the DB Migration Image
* Migrate the database using following command
```shell
podman run flyway-image jdbc:postgresql://host.docker.internal:5432/sonataflow <your-db-user> <your-db-password>
```
* You should see output, which contains the following
```text
+-----------+---------+------------------------------+--------+---------------------+---------+----------+
| Category  | Version | Description                  | Type   | Installed On        | State   | Undoable |
+-----------+---------+------------------------------+--------+---------------------+---------+----------+
|           |         | << Flyway Schema Creation >> | SCHEMA | 2024-06-24 15:14:02 | Success |          |
| Versioned | 1.0.1   | di mytable                   | SQL    | 2024-06-24 15:14:02 | Success | No       |
| Versioned | 1.0.2   | di mytable2                  | SQL    | 2024-06-24 15:14:02 | Success | No       |
| Versioned | 1.0.3   | js mytable2                  | SQL    | 2024-06-24 15:14:02 | Success | No       |
| Versioned | 1.0.4   | js mytable                   | SQL    | 2024-06-24 15:14:02 | Success | No       |
+-----------+---------+------------------------------+--------+---------------------+---------+----------+
```
* Verify the database indeed has the tables shown above.