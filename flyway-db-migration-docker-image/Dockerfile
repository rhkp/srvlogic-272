FROM flyway/flyway

RUN mkdir /flyway/jars
COPY postgresql-42.7.3.jar /flyway/jars
COPY di-db-migration-files /di-db-migration-files
COPY js-db-migration-files /js-db-migration-files

#RUN mkdir /flyway/sql
#COPY *.sql /flyway/sql

COPY migration.sh .

RUN chmod +x ./migration.sh

ENTRYPOINT ["./migration.sh"]
CMD ["URL", "USER"]

#RUN echo "LISTING SQL DIR"
#RUN ls /flyway/sql

#RUN flyway -url=jdbc:h2:mem:test -user=sa info

#ENV jdbc_url $JDBC_URL
#ENV pg_user $PG_USER
#ENV pg_password $PG_PASSWORD
#ENV pg_db $PG_DB

#FROM alpine:latest
#ARG name
#ENV env_name $name
