import json
import subprocess
import sys


def getAdminURLCore(kube_config, instid):
    try:
        result = {"admin_url": ""}
        process = subprocess.Popen(
            [
                "oc",
                "get",
                "route",
                "-n",
                f"mas-{instid}-core",
                "-o",
                "json",
                "--kubeconfig",
                kube_config,
            ],
            stdout=subprocess.PIPE,
            universal_newlines=True,
        )

        output, _ = process.communicate()

        if process.returncode != 0:
            varstr = ""
            result["admin_url"] = varstr
            json_output = json.dumps(result)
            return json_output

        data = json.loads(output)
        routes = data.get("items", [])

        for route in routes:
            if f"admin.{instid}" in route["spec"]["host"]:
                varstr = route["spec"]["host"]
                break
        if varstr != "":
            result["admin_url"] = f"https://{varstr}"
        else:
            varstr = "InstallFailed"
            result["admin_url"] = varstr

        json_output = json.dumps(result)
        print(json_output)
        filename = "url.txt"
        with open(filename, "w") as file:
            file.write(result["admin_url"])
        return 0

    except Exception as e:
        varstr = f"CaughtException: {e}"
        result["admin_url"] = varstr
        json_output = json.dumps(result)
        print(json_output)
        sys.exit(1)


if __name__ == "__main__":
    # get KUBECONFIG containing path from json passed to the command as an argument
    # Read the JSON input from stdin
    input_json = json.loads(sys.stdin.read())

    # get the KUBECONFIG path from the json
    kubeconfig = input_json["KUBECONFIG"]

    instanceId = sys.argv[1]

    getAdminURLCore(kube_config=kubeconfig, instid=instanceId)
