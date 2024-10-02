#! /bin/bash

set -e

rg=$1

export IBMCLOUD_VERSION_CHECK=false

if [ -z "${IBMCLOUD_API_KEY}" ]; then
  echo "Please set required variable IBMCLOUD_API_KEY"
  exit 1
fi

if [ -z "${rg}" ]; then
  echo "Please pass a resource group name as the first argument to the script"
  exit 1
fi

ibmcloud login
json=$(ibmcloud resource service-instances -g "${rg}" --type all --output json | jq -c)
volumes=()
while IFS='' read -r line; do volumes+=("$line"); done < <(echo "${json}" | jq -r '.[].id')
for id in "${volumes[@]}"; do
  # extract volume id
  vol_id="${id#*::volume:}"
  region=$(echo "${json}" | jq -r --arg id "${id}" '.[] | select(.id == $id) | .region_id')
  ibmcloud target -r "${region}"
  ibmcloud is volume-delete "${vol_id}" -f
done
