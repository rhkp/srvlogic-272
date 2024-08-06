# SRVLOGIC-272 - Persistency and schema initialization handling
oc create namespace aswf
oc project aswf

# Create username and password secrets for the Postgres DB
oc create secret generic postgres-secrets --from-literal=POSTGRES_USER=your-db-user --from-literal=POSTGRES_PASSWORD=your-db-password --from-literal=POSTGRES_DB=sonataflow --from-literal=PGDATA=/var/lib/postgresql/data/mydata

# Deploy Postgres database
oc apply -f pg.yaml
oc wait --for=condition=Ready "$(oc get pod -o name | grep postgres)" --timeout=3m

# Migrate the database with the job
oc apply -f sonataflow-db-migration-job.yaml
oc wait --for=condition=complete --timeout=3m job/sonataflow-db-migrator-job -n aswf