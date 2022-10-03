#!/bin/bash

RELEASE_NAME=$1
NAMESPACE=$2
RELEASE_NUMBER=${3:-""}

sleep 5

echo "Verifying $RELEASE_NAME Deployment in $NAMESPACE Namespace"

if [[ -z $RELEASE_NUMBER ]]; then
    echo "No Release Version Provided so Fetching Latest Release Version"
    RELEASE_NUMBER=$(kubectl get deployments -n $NAMESPACE -o jsonpath='{.items[*].metadata.labels.release}' | awk 'NR==1{print $1}')
fi


echo "Namespace         :   $NAMESPACE"
echo "Release Name      :   $RELEASE_NAME"
echo "Release Number    :   $RELEASE_NUMBER"

echo ""
echo "Checking Rollout Status"

APPLICATIONS=$(kubectl get deployments -n $NAMESPACE | awk 'NR>1{print $1}')
for APPLICATION in $APPLICATIONS
do
    echo "Checking Status of $APPLICATION"
    kubectl rollout status deployments/$APPLICATION -n $NAMESPACE
    echo ""
    echo ""
done    

echo ""
echo ""
echo "$RELEASE_NAME Deployment Status for Release $RELEASE_NUMBER"
kubectl get pods -n $NAMESPACE -l release=$RELEASE_NUMBER