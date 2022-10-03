#!/bin/bash

# Define the helm details
RELEASE_NAME=$1
CONFIGURATION_FILE=$2
NAMESPACE=$3
RELEASE_NUMBER=${4:-""}
DEPLOYER=${5:-"SCHEDULED"}


echo "Release Deployer: " $DEPLOYER
echo "Release Name: " $RELEASE_NAME
echo "Release Number: " $RELEASE_NUMBER
echo "Release Namespace: " $NAMESPACE

helm upgrade  --install --namespace ${NAMESPACE} --timeout 600s "${RELEASE_NAME}" client-registration/ --values config/$CONFIGURATION_FILE --set image.tag="${RELEASE_NUMBER}" --set core.deployer="${DEPLOYER}"