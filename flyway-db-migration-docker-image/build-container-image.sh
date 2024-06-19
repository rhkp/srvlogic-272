#!/bin/sh

# Download Postgres JDBC driver
rm -f postgresql-42.7.3.jar
wget https://jdbc.postgresql.org/download/postgresql-42.7.3.jar

podman build -t flyway-image .