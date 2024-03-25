set -e

sleep 300

# Function to track the status of MAS Core+Manage pipeline and to exit in case of failure and to wait for all retries in case if the pipeline is still running.
function verifyPipelineStatusManage()
{
for (( i=0; i<=60; i++ ));
        do
        varstr3=$(oc get pr -n mas-${var2}-pipelines | awk -F' ' '{print $3}')
        varstr3=$(echo $varstr3 | cut -d ' ' -f 1)

        varstr4=$(oc get pr -n mas-${var2}-pipelines | awk -F' ' '{print $3}')
        varstr4=$(echo $varstr4 | cut -d ' ' -f 2)

        if [[ $varstr3 == "REASON" && $varstr4 == "Completed"  ]]; then
                echo "Install pipeline as completed successfully"
                echo -n '{"PipelineRunStatus":"'"Successful"'"}' > result.txt
                chmod +x result.txt
                break
        elif [[ $varstr3 == "REASON" && $varstr4 == "Running"  ]]; then
                echo "Install pipeline is still running"
                sleep 300
        elif [[ $varstr3 == "REASON" && $varstr4 == "Failed"  ]]; then
        varstr5=$(oc get taskrun -A -n mas-${var2}-pipelines | grep Failed | awk -F' ' '{print $2}')
                echo $varstr5 "task run failed"
                break
        fi
        done
}

# Function to track the status of MAS Core pipeline and to exit in case of failure and to wait for all retries in case if the pipeline is still running.
function verifyPipelineStatusCore()
{
for (( i=0; i<=30; i++ ));
        do
        varstr3=$(oc get pr -n mas-${var2}-pipelines | awk -F' ' '{print $3}')
        varstr3=$(echo $varstr3 | cut -d ' ' -f 1)

        varstr4=$(oc get pr -n mas-${var2}-pipelines | awk -F' ' '{print $3}')
        varstr4=$(echo $varstr4 | cut -d ' ' -f 2)

        if [[ $varstr3 == "REASON" && $varstr4 == "Completed"  ]]; then
                echo "Install pipeline as completed successfully"
                echo -n '{"PipelineRunStatus":"'"Successful"'"}' > result.txt
                chmod +x result.txt
                break
        elif [[ $varstr3 == "REASON" && $varstr4 == "Running"  ]]; then
                echo "Install pipeline is still running"
                sleep 180
        elif [[ $varstr3 == "REASON" && $varstr4 == "Failed"  ]]; then
        varstr5=$(oc get taskrun -A -n mas-${var2}-pipelines | grep Failed | awk -F' ' '{print $2}')
                echo $varstr5 "task run failed"
                varstr6=$varstr5"_failed"
                echo -n '{"PipelineRunStatus":"'"${varstr6}"'"}' > result.txt
                chmod +x result.txt
                break
        fi        
        done
}
var1=$1
var2=$2
echo "Deployment flavour is:" $1
echo "Instance Id is:" $2

if [[ $var1 == "core" ]]; then
verifyPipelineStatusCore
elif [[ $var1 == "manage" ]]; then
verifyPipelineStatusManage
else
echo "Invalid deployment flavour option is inputted"
exit 1
fi
