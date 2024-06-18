# SRVLOGIC-272 - Persistency and schema initialization handling
oc create namespace aswf

# Install SonataFlow Operator
oc create -f https://raw.githubusercontent.com/kiegroup/kogito-serverless-operator/main/operator.yaml

# Create username and password secrets for the Postgres DB
oc create secret generic postgres-secrets --from-literal=POSTGRES_USER=your-db-user --from-literal=POSTGRES_PASSWORD=your-db-password --from-literal=POSTGRES_DB=sonataflow --from-literal=PGDATA=/var/lib/postgresql/data/mydata

oc apply -f pg.yaml
oc apply -f sonataflow-platform.yaml

oc get pod -n aswf --watch