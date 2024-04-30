#!/bin/bash

deployment_flavour=$1
instance_id=$2
echo "Deployment flavour is:" "$deployment_flavour"
echo "Instance Id is:" "$instance_id"

if [[ $deployment_flavour == "core" ]]; then
        num_of_retries=30
elif [[ $deployment_flavour == "manage" ]]; then
        num_of_retries=100

fi

for (( i=0; i<=num_of_retries; i++ ));
        do
        varstr3=$(oc get pr -n "mas-${instance_id}-pipelines" -o=jsonpath='{.items[*].status.conditions[*].reason}')

        if [[ $varstr3 == "Completed"  ]]; then
                echo "Install pipeline has completed successfully"
                echo -n "Successful" > result.txt
                chmod +x result.txt
                break
        elif [[ $varstr3 == "Running"  ]]; then
                echo "Install pipeline is still running"
                varstr5=$(oc get taskrun -A -n "mas-${instance_id}-pipelines" | grep Running | awk -F' ' '{print $2}')
                echo "Current running task is: " "$varstr5"
				# If it's taking too long to complete then it's unusual behavior and looks like it's failing. Hence exit deployment after 30 retries.
                if [[ $i == 30 ]]; then
				echo "Pipeline is taking too long time to complete which is unusual. Please check the pipeline status on Openshift console."
				exit 1
				fi
                sleep 180
        elif [[ $varstr3 == "Failed"  ]]; then
        varstr5=$(oc get taskrun -A -n "mas-${instance_id}-pipelines" | grep Failed | awk -F' ' '{print $2}')
                echo "Failed task is: " "$varstr5"
                exit 1
        fi
        done
