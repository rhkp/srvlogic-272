# DB Migration Image creating DI/JS specific new DBs, using UBI9 minimal image using cekit
This image demonstrates creating DI/JS application's their own specific databases. Meaning the scripts create a database `di` for data index and `js` for jobs service.
Note: This is a concept demo only and it does not use all DI/JS sql files.

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

## Run the DB Migration Image
* Migrate the database using following command
```shell
podman run flyway-image jdbc:postgresql://host.docker.internal:5432/postgresql <your-db-user> <your-db-password>
```
* You should see output, which contains the text somewhat like the following
```text
+-----------+---------+------------------------------+--------+---------------------+---------+----------+
| Category  | Version | Description                  | Type   | Installed On        | State   | Undoable |
+-----------+---------+------------------------------+--------+---------------------+---------+----------+
|           |         | << Flyway Schema Creation >> | SCHEMA | 2024-07-10 18:59:07 | Success |          |
| Versioned | 1.0.1   | di mytable                   | SQL    | 2024-07-10 19:05:47 | Success | No       |
| Versioned | 1.0.2   | di mytable2                  | SQL    | 2024-07-10 19:05:48 | Success | No       |
| Versioned | 1.0.3   | js mytable2                  | SQL    | 2024-07-10 19:09:15 | Success | No       |
| Versioned | 1.0.4   | js mytable                   | SQL    | 2024-07-10 19:09:15 | Success | No       |
+-----------+---------+------------------------------+--------+---------------------+---------+----------+
```
* Verify the postgres server indeed has the databases di/js and tables shown above.