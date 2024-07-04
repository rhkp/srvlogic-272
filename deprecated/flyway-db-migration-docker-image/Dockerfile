FROM flyway/flyway

RUN mkdir /flyway/jars
RUN mkdir /sql

RUN chgrp -R 0 /sql && chmod -R g=u /sql

COPY db-migration-files /db-migration-files

COPY migration.sh .

RUN chmod +x ./migration.sh

ENTRYPOINT ["./migration.sh"]