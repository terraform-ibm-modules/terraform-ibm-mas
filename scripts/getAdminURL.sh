#!/bin/bash

set -e

# Function to fetch admin URL of Maximo Application Suite console.
# This function retries for 5 times to fetch the URL with wait of 60 seconds between each retry.
function getAdminURL() {
  for (( i=1; i<=5; i++ )); do
    varstr=$(oc get route -n "mas-${var1}-core" --no-headers | grep "admin.${var1}" | awk '{print $2}')
    if [[ -n $varstr ]]; then
      varstr="https://"$varstr
      echo -n "${varstr}" > url.txt
    elif [[ -z $varstr ]]; then
      if [[ $i == 5 ]]; then
        echo "Admin URL can't be fetched. Something wrong. Please check on Openshift cluster."
        exit 1
      fi
     sleep 60
    fi
  done
}

# main
var1=$1

getAdminURL
