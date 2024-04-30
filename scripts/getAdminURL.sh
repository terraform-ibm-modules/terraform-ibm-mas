#!/bin/bash

set -e

# Function to fetch admin URL of Maximo Application Suite console.
# This function retries for 5 times to fetch the URL with wait of 60 seconds between each retry.
function getAdminURL() {

  local id=$1
  local local_file=$2

  for (( i=1; i<=5; i++ )); do
    # TODO: update to use -o=jsonpath
    varstr=$(oc get route -n "mas-${id}-core" --no-headers | grep "admin.${id}" | awk '{print $2}')
    if [[ -n ${varstr} ]]; then
      varstr="https://${varstr}"
      echo -n "${varstr}" > "${local_file}"
    elif [[ -z $varstr ]]; then
      if [[ $i == 5 ]]; then
        echo "Admin URL can't be fetched. Something wrong. Please check on Openshift cluster."
        exit 1
      fi
      time_sleep=60
      echo
      echo "Sleeping for ${time_sleep} seconds before retrying.."
	  sleep ${time_sleep}
    fi
  done
}

# main
var1=$1
var2=$2

getAdminURL "${var1}" "${var2}"
