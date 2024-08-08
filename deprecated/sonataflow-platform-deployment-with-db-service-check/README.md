# Deploy SonataFlow Platform resources (Postgres, Data Index and Job Service) with persistence on an OpenShift cluster with database service checks

## Issue description
[SRVLOGIC-272: Persistency and schema initialization handling](https://issues.redhat.com/browse/SRVLOGIC-272)

## Prerequisites
* Running OpenShift 4.15 cluster
* Working oc command on developer machine

## Installation of SonataFlow Platform Resources
* Run the following command in a terminal
```shell
./install-sonataflow-platform.sh
```

## Uninstall SonataFlow Platform Resources
```shell
oc delete ns aswf
```

