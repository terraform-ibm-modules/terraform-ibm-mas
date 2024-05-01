#!/bin/bash

set -e

deployment_flavour=$1
instance_id=$2

echo "Deployment flavour is: ${deployment_flavour}"
echo "Instance ID is: ${instance_id}"
echo

# sleep for 30 seconds to allow some tasks to start
sleep 30

namespace="mas-${instance_id}-pipelines"

if [[ "${deployment_flavour}" == "core" ]]; then
  num_of_retries=90
elif [[ "${deployment_flavour}" == "manage" ]]; then
  num_of_retries=200
else
  echo "Unsupported deployment flavour: ${deployment_flavour}"
  exit 1
fi

for (( i=0; i<=num_of_retries; i++ )); do
  reason=$(oc get pr -n "${namespace}" -o=jsonpath='{.items[*].status.conditions[*].reason}')
  if [[ "${reason}" == "Completed"  ]]; then
    echo "Install pipeline has completed successfully"
    break
  elif [[ "${reason}" == "Running"  ]]; then
    echo "Install pipeline is still running.."
    running_tasks=$(oc get taskrun -n "${namespace}" | grep Running | awk -F' ' '{print $1}')
    printf 'Current running task(s) are:\n%s\n' "${running_tasks}"
    # If it's taking too long to complete then it's unusual behavior and looks like it's failing. Hence exit deployment after 30 retries.
    if [[ $i == "${num_of_retries}" ]]; then
      echo
      echo "Pipeline is taking too long time to complete which is unusual. Please check the pipeline status in the Openshift console."
      exit 1
    fi
    time_sleep=60
    echo
    echo "Sleeping for ${time_sleep} seconds before retrying.."
    sleep ${time_sleep}
  elif [[ "${reason}" == "Failed"  ]]; then
    failed_tasks=$(oc get taskrun -n "${namespace}" | grep Failed | awk -F' ' '{print $1}')
    echo
    printf 'Detected the following failed task(s):\n%s\n' "${failed_tasks}"
    echo "Exiting."
    exit 1
  fi
done
