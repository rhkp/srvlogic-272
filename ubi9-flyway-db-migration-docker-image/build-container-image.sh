#!/bin/sh

rm -f *.gz
rm -rf ./flyway

wget https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/10.15.1/flyway-commandline-10.15.1-linux-x64.tar.gz

tar xvf ./flyway-commandline-10.15.1-linux-x64.tar.gz
mv flyway-10.15.1 flyway

docker build -t flyway-image .