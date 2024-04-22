set -e

var1=$1

for (( i=0; i<=60; i++ ));
        do
        varstr3=$(oc get pr -n mas-${var1}-pipelines | awk -F' ' '{print $3}')
        varstr3=$(echo $varstr3 | cut -d ' ' -f 1)

        varstr4=$(oc get pr -n mas-${var1}-pipelines | awk -F' ' '{print $3}')
        varstr4=$(echo $varstr4 | cut -d ' ' -f 2)

        if [[ $varstr3 == "REASON" && $varstr4 == "Completed"  ]]; then
                break
        elif [[ $varstr3 == "REASON" && $varstr4 == "Running"  ]]; then
                echo "Install pipeline is taking more than expected time. Something is incorrect. Please check the pipeline task status on Openshift Cluster"
                exit
        elif [[ $varstr3 == "REASON" && $varstr4 == "Failed"  ]]; then
                echo "Install pipeline has failed"
                exit
        fi
		done
}