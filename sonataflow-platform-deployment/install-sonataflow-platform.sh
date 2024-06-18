# SRVLOGIC-272 - Persistency and schema initialization handling
oc create namespace aswf

# Install SonataFlow Operator
oc create -f https://raw.githubusercontent.com/kiegroup/kogito-serverless-operator/main/operator.yaml

# Install Postgres DB instance
oc new-app postgresql:13-el8~https://github.com/sclorg/postgresql-container.git \
  --name sonataflow-postgresql \
  -e POSTGRESQL_USER=your-db-user \
  -e POSTGRESQL_DATABASE=rh-db \
  -e POSTGRESQL_PASSWORD=your-db-password

# Create username and password secrets for the Postgres DB
oc create secret generic postgres-secrets --from-literal=POSTGRESQL_USER=your-db-user --from-literal=POSTGRESQL_PASSWORD=your-db-password

sleep 180

oc apply -f swf-platform.yaml
oc get pod -n aswf --watch