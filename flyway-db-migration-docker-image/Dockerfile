FROM flyway/flyway

RUN mkdir /flyway/jars
RUN mkdir /sql

RUN chgrp -R 0 /sql && chmod -R g=u /sql

COPY di-db-migration-files /di-db-migration-files
COPY js-db-migration-files /js-db-migration-files

COPY migration.sh .

RUN chmod +x ./migration.sh

ENTRYPOINT ["./migration.sh"]