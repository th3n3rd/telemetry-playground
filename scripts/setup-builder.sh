#!/bin/bash

set -e

REGISTRY_USERNAME=th3n3rd

echo "Requirement: should be already logged in on docker"

# https://github.com/vmware-tanzu/kpack-cli/issues/155
echo "> Creating default image registry credentials in the kpack namespace"
kp secret delete image-registry-credentials -n kpack || true
kp secret create image-registry-credentials \
  --dockerhub $REGISTRY_USERNAME \
  -n kpack

# https://github.com/vmware-tanzu/kpack-cli/issues/155
echo "> Creating image registry credentials in the default namespace"
kp secret delete image-registry-credentials || true
kp secret create image-registry-credentials \
  --dockerhub $REGISTRY_USERNAME \
  -n default

echo "Exiting for now"
exit 0

echo "> Setting up default repository and service account"
kp config default-repository th3n3rd
kp config default-service-account default

echo "> Create default cluster store (set of buildpacks)"
kp clusterstore save default \
  -b gcr.io/paketo-buildpacks/java \
  -b gcr.io/paketo-buildpacks/spring-boot

echo "> Create base cluster stack (base + run image)"
kp clusterstack save base \
  --build-image paketobuildpacks/build:base-cnb \
  --run-image paketobuildpacks/run:base-cnb

echo "> Create a builder (stack + store + order)"
kp builder save shared-builder \
  --tag th3n3rd/shared-builder \
  --store default \
  --stack base \
  --buildpack packeto-buildpacks/java \
  --buildpack packeto-buildpacks/spring-boot


