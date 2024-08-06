# sonataflow-db-migrator

This is a quarkus database migrator application for Sonataflow Data Index and Jobs Service.

## Running the application in dev mode

You can run your application in dev mode that enables live coding using:

```shell script
./mvnw compile quarkus:dev
```

> **_NOTE:_**  Quarkus now ships with a Dev UI, which is available in dev mode only at <http://localhost:8080/q/dev/>.

## Build and Run cekit image locally
You can build the cekit container image by using the provided image builder shell script
```shell
./build-container-image.sh
```
Ensure the script completes without errors.
If you may have a cekit specific Python virtual environment, be sure to activate it, so the script can find the cekit command.
```shell
virtualenv ~/cekit
source ~/cekit/bin/activate;
```

Assuming you have Postgres database running locally, you can run the image by command as follows, just substitute appropriate values.
```shell
podman run --env QUARKUS_DATASOURCE_JDBC_URL=<your-db-url e.g. jdbc:postgresql://host.docker.internal:5432/postgres> --env QUARKUS_DATASOURCE_USERNAME=<your-db-user> --env QUARKUS_DATASOURCE_PASSWORD=<your-db-password> docker.io/apache/incubator-kie-kogito-service-db-migration-postgresql:999-SNAPSHOT
```

## Packaging and running the application

The application can be packaged using:

```shell script
./mvnw package
```

It produces the `quarkus-run.jar` file in the `target/quarkus-app/` directory.
Be aware that it’s not an _über-jar_ as the dependencies are copied into the `target/quarkus-app/lib/` directory.

The application is now runnable using `java -jar target/quarkus-app/quarkus-run.jar`.

If you want to build an _über-jar_, execute the following command:

```shell script
./mvnw package -Dquarkus.package.jar.type=uber-jar
```

The application, packaged as an _über-jar_, is now runnable using `java -jar target/*-runner.jar`.

## Creating a native executable

You can create a native executable using:

```shell script
./mvnw package -Dnative
```

Or, if you don't have GraalVM installed, you can run the native executable build in a container using:

```shell script
./mvnw package -Dnative -Dquarkus.native.container-build=true
```

You can then execute your native executable with: `./target/sonataflow-db-migrator-1.0-SNAPSHOT-runner`

If you want to learn more about building native executables, please consult <https://quarkus.io/guides/maven-tooling>.

## Related Guides

- Flyway ([guide](https://quarkus.io/guides/flyway)): Handle your database schema migrations
- JDBC Driver - PostgreSQL ([guide](https://quarkus.io/guides/datasource)): Connect to the PostgreSQL database via JDBC
