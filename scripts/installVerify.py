import json
import subprocess
import sys
import time


def verifyPipelineStatus(kube_config, instid, capability):
    RETRY_COUNT = 0
    TIME_TO_WAIT = 0
    if capability == "core":
        RETRY_COUNT = 30
        TIME_TO_WAIT = 180
    elif capability == "manage":
        RETRY_COUNT = 60
        TIME_TO_WAIT = 300

    try:
        pipline_status = ""
        for _ in range(RETRY_COUNT):
            process = subprocess.Popen(
                [
                    "oc",
                    "get",
                    "pr",
                    "-n",
                    f"mas-{instid}-pipelines",
                    "-o",
                    "json",
                    "--kubeconfig",
                    kube_config
                ],
                stdout=subprocess.PIPE,
                universal_newlines=True,
            )

            output, _ = process.communicate()

            if process.returncode != 0:
                pipline_status = "OC_COMMAND_EXECUTION_FAILRE"
                result = {"PipelineRunStatus": pipline_status}
                json_output = json.dumps(result)
                print(json_output)
                return

            data = json.loads(output)
            pipeline_runs = data.get("items", [])

            pipeline_run = None

            if len(pipeline_runs) > 0:
                pipeline_run = pipeline_runs[0]
            else:
                pipline_status = "NO_PIPELINE_RESOURCE_FOUND"
                break

            if pipeline_run:

                pipeline_status_reason = (
                    pipeline_run.get("status").get("conditions")[0].get("reason")
                )
                if pipeline_status_reason == "Completed":
                    pipline_status = "Successful"
                    break

                elif pipeline_status_reason == "Running":
                    # current_task = findCurrentRunningTask(kube_config)
                    # current_status = {
                    #     "currentRunningTask": current_task
                    # }
                    time.sleep(TIME_TO_WAIT)
                    pass
                elif pipeline_status_reason == "Failed" or pipeline_status_reason == "PipelineRunStopping":
                    pipline_status = getFailureMessage(kube_config)
                    break
                else:
                    pipline_status = "UNKNOWN_PIPELINE_STATUS"
        result = {"PipelineRunStatus": pipline_status}
        json_output = json.dumps(result)
        print(json_output)

    except Exception as e:
        error = {"PipelineRunStatus": str(e)}
        json_error = json.dumps(error)
        print(json_error)


def getFailureMessage(kube_config):
    failure_msg = ""
    process = subprocess.Popen(
        [
            "oc",
            "get",
            "taskrun",
            "-A",
            "-o",
            "json",
            "--kubeconfig",
            kube_config
        ],
        stdout=subprocess.PIPE,
        universal_newlines=True,
    )

    output, _ = process.communicate()
    data = json.loads(output)
    pipeline_task_runs = data.get("items", [])
    for pipeline_task in pipeline_task_runs:
        task_status = pipeline_task.get("status").get("conditions")[0].get("reason")
        if task_status == "Failed":
            failure_msg = pipeline_task.get("status").get("conditions")[0].get("message")
    return failure_msg


def findCurrentRunningTask(kube_config):
    current_running_task = ""
    process = subprocess.Popen(
        [
            "oc",
            "get",
            "taskrun",
            "-A",
            "-o",
            "json",
            "--kubeconfig",
            kube_config
        ],
        stdout=subprocess.PIPE,
        universal_newlines=True,
    )

    output, _ = process.communicate()
    data = json.loads(output)
    pipeline_task_runs = data.get("items", [])
    for pipeline_task in pipeline_task_runs:
        task_status = pipeline_task.get("status").get("conditions")[0].get("reason")
        if task_status == "Pending":
            current_running_task = pipeline_task.get("labels").get("tekton.dev/pipelineTask")
    return current_running_task


if __name__ == "__main__":
    # get KUBECONFIG containing path from json passed to the command as an argument
    # Read the JSON input from stdin
    input_json = json.loads(sys.stdin.read())

    # get the KUBECONFIG path from the json
    kubeconfig = input_json["KUBECONFIG"]

    verifyPipelineStatus(
        kube_config=kubeconfig, capability=sys.argv[1], instid=sys.argv[2]
    )
