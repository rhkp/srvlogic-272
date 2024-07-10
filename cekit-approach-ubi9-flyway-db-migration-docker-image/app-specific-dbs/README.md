# DB Migration Image using UBI9 minimal image using cekit

## Issue description
[SRVLOGIC-272: Persistency and schema initialization handling](https://issues.redhat.com/browse/SRVLOGIC-272)

## Prerequisites
* Running Podman command and Podman Desktop
* Working cekit command, see install [instructions](https://docs.cekit.io/en/latest/handbook/installation/instructions.html)
* Postgres database running and accessible with available credentials
* The db migration sql files tar ball `db-migration-files.tar` is available from github, which the script downloads

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
* You should see output, which contains the text somewhat like the following
```text
+-----------+----------+------------------------------------+--------+---------------------+---------+----------+
| Category  | Version  | Description                        | Type   | Installed On        | State   | Undoable |
+-----------+----------+------------------------------------+--------+---------------------+---------+----------+
|           |          | << Flyway Schema Creation >>       | SCHEMA | 2024-06-27 16:18:39 | Success |          |
| Versioned | 1.0.1    | di mytable                         | SQL    | 2024-06-27 16:18:39 | Success | No       |
| Versioned | 1.0.2    | di mytable2                        | SQL    | 2024-06-27 16:18:39 | Success | No       |
| Versioned | 1.0.3    | js mytable2                        | SQL    | 2024-06-27 16:18:39 | Success | No       |
| Versioned | 1.0.4    | js mytable                         | SQL    | 2024-06-27 16:18:39 | Success | No       |
| Versioned | 1.32.0   | data index create                  | SQL    | 2024-06-27 16:18:39 | Success | No       |
| Versioned | 1.44.0   | data index definitions             | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 1.45.0.0 | data index node definitions        | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 1.45.0.1 | add identity to process instance   | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 1.45.0.2 | data index definitions add columns | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 1.45.0.3 | add fk index                       | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 1.45.0.4 | increase varchar length            | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 2.0.0    | Create Table                       | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 2.0.1    | job details increase job id size   | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 2.0.2    | job details add fire time col      | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 2.0.3    | Create Table Management            | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 3.0.0    | Create Jobs Table V2               | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 3.0.1    | Migrate Jobs v1 to v2 Table        | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 3.0.2    | Add Execution Timeout Col          | SQL    | 2024-06-27 16:18:40 | Success | No       |
| Versioned | 3.0.3    | Add Created Col                    | SQL    | 2024-06-27 16:18:40 | Success | No       |
+-----------+----------+------------------------------------+--------+---------------------+---------+----------+
```
* Verify the database indeed has the tables shown above.