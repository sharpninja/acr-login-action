#!/usr/bin/env bash
set -e

# echo "::add-mask::${INPUT_SERVICE_PRINCIPAL_PASSWORD}"
echo "INPUT_SERVICE_PRINCIPAL: ${INPUT_SERVICE_PRINCIPAL}"
echo "INPUT_SERVICE_PRINCIPAL_PASSWORD: ${INPUT_SERVICE_PRINCIPAL_PASSWORD}"
echo "INPUT_TENANT: ${INPUT_TENANT}"

echo "az login --service-principal -u ${INPUT_SERVICE_PRINCIPAL} -p ${INPUT_SERVICE_PRINCIPAL_PASSWORD} --tenant ${INPUT_TENANT}"
az login --service-principal -u ${INPUT_SERVICE_PRINCIPAL} -p ${INPUT_SERVICE_PRINCIPAL_PASSWORD} --tenant ${INPUT_TENANT}

authTokenOutput=$(az acr token create -n 'github-actions-token' -r ${INPUT_REGISTRY} --repository ${INPUT_REPOSITORY} content/read content/write)
USERNAME=$(echo "$authTokenOutput" | jq -r '.credentials.username')
PASSWORD=$(echo "$authTokenOutput" | jq -r '.credentials.passwords[0].value')

echo "::set-output name=username::${USERNAME}"
echo "::set-output name=password::${PASSWORD}"
echo "USERNAME: ${USERNAME}"
echo "PASSWORD: ${PASSWORD}"
