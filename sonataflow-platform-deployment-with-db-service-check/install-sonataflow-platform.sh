# SRVLOGIC-272 - Persistency and schema initialization handling
oc create namespace aswf
oc project aswf

# Install SonataFlow Operator
# oc create -f https://raw.githubusercontent.com/kiegroup/kogito-serverless-operator/main/operator.yaml
oc project sonataflow-operator-system
oc wait --for=jsonpath='{.status.phase}'=Running "$(oc get pod -o name | grep sonataflow-operator-controller-manager)" --timeout=3m

# Create username and password secrets for the Postgres DB
oc project aswf
oc create secret generic postgres-secrets --from-literal=POSTGRES_USER=your-db-user --from-literal=POSTGRES_PASSWORD=your-db-password --from-literal=POSTGRES_DB=sonataflow --from-literal=PGDATA=/var/lib/postgresql/data/mydata

# Deploy Postgres database
oc apply -f pg.yaml
oc wait --for=condition=Ready "$(oc get pod -o name | grep postgres)" --timeout=3m

# Migrate the database with the job
oc apply -f flyway-image-db-migration-job.yaml
oc wait --for=condition=complete --timeout=3m job/flyway-image-job -n aswf

# Deploy the Sonataflow Platform resources
oc apply -f sonataflow-platform.yaml
oc get pod -n aswf --watch