#!/bin/sh

cekit -v build podman
podman push flyway-image quay.io/rhkp/flyway-image
