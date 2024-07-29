#!/bin/sh

rm -f *.gz
rm -rf ./flyway

wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/10.17.0/flyway-commandline-10.17.0-linux-x64.tar.gz

tar xvf ./flyway-commandline-10.17.0-linux-x64.tar.gz
mv flyway-10.17.0 flyway

docker build -t flyway-image .