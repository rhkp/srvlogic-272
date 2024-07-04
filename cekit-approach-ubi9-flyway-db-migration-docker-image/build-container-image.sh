#!/bin/sh

# cleanup temporary files
cleanup () {
    rm -f flyway-commandline-10.15.1-linux-x64.tar.gz flyway.tar.gz db-migration-files.tar db-migration-files.tar
    rm -rf modules/install-deps/artifacts
    rm -rf target
}

# Start with a clean slate
cleanup

# Flyway
wget https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/10.15.1/flyway-commandline-10.15.1-linux-x64.tar.gz
mv flyway-commandline-10.15.1-linux-x64.tar.gz flyway.tar.gz

# DB Migration files
tar -cvf db-migration-files.tar db-migration-files

mkdir -p ./modules/install-deps/artifacts
cp ./db-migration-files.tar ./flyway.tar.gz ./migration.sh ./modules/install-deps/artifacts

# Build and push
cekit -v build podman &&
podman push flyway-image quay.io/rhkp/flyway-image

# Cleanup after completion
cleanup