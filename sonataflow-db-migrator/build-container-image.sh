#!/bin/sh

# cleanup temporary files
cleanup () {
    rm -rf target
    rm -rf src/main/resources/postgresql
    rm -rf tmp
    rm -f src/main/cekit/modules/kogito-postgres-db-migration-deps/sonataflow-db-migrator-1.0-SNAPSHOT-runner.jar
}

# Start with cleanup
cleanup

# Get Data Index/ Jobs Service DDL Files
mkdir -p tmp
wget https://repository.apache.org/content/groups/snapshots/org/kie/kogito/kogito-ddl/10.0.999-SNAPSHOT/kogito-ddl-10.0.999-20240806.011718-23-db-scripts.zip
mv kogito-ddl-10.0.999-20240806.011718-23-db-scripts.zip tmp
cd tmp
unzip kogito-ddl-10.0.999-20240806.011718-23-db-scripts.zip
mv ./postgresql ../src/main/resources
cd ..

# Create an Uber jar
mvn package -Dquarkus.package.jar.type=uber-jar
cp target/sonataflow-db-migrator-1.0-SNAPSHOT-runner.jar src/main/cekit/modules/kogito-postgres-db-migration-deps

# Build the container image
cd src/main/cekit
cekit -v build podman

# Cleanup
cd ../../..
cleanup