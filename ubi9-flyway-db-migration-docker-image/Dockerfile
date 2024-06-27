FROM registry.access.redhat.com/ubi9:9.4-1123

WORKDIR /home/default

COPY flyway .

COPY db-migration-files db-migration-files

COPY migration.sh .

RUN chmod +x migration.sh

RUN chgrp -R 0 /home/default && chmod -R g=u /home/default

ENTRYPOINT ["/home/default/migration.sh"]
