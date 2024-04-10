import json
import subprocess
import sys


def getAdminURLCore(kube_config, instid):
    try:
        process = subprocess.Popen(['oc', 'get', 'route',
                                    '-n', f'mas-{instid}-core',
                                    '-o', 'json',
                                    '--kubeconfig', kube_config],
                                   stdout=subprocess.PIPE, universal_newlines=True)

        output, _ = process.communicate()

        if process.returncode != 0:
            print("Error: Failed to execute 'oc get route' command")
            sys.exit(1)

        data = json.loads(output)
        routes = data.get('items', [])

        for route in routes:
            if f'admin.{instid}' in route['spec']['host']:
                varstr = route['spec']['host']
                break
        else:
            print(f"Error: No route found for 'admin.{instid}'")
            sys.exit(2)

        result = {
            "admin_url": f"https://{varstr}"
        }
        json_output = json.dumps(result)
        print(json_output)

    except json.JSONDecodeError as e:
        print(f"Error: Failed to parse JSON: {e}")
        sys.exit(3)

    except subprocess.CalledProcessError as e:
        print(f"Error: Command '{e.cmd}' returned non-zero exit status {e.returncode}")
        sys.exit(4)

    except OSError as e:
        print(f"Error: Failed to execute command: {e}")
        sys.exit(5)

def getAdminURLManage(kube_config, instid, workspaceId):
    try:
        process = subprocess.Popen(['oc', 'get', 'route',
                                    '-n', f'mas-{instid}-manage',
                                    '-o', 'json',
                                    '--kubeconfig', kube_config],
                                   stdout=subprocess.PIPE, universal_newlines=True)

        output, _ = process.communicate()

        if process.returncode != 0:
            print("Error: Failed to execute 'oc get route' command")
            sys.exit(1)

        data = json.loads(output)
        routes = data.get('items', [])

        for route in routes:
            if f'{workspaceId}-all.manage.{instid}' in route['spec']['host']:
                varstr = route['spec']['host']
                break
        else:
            print(f"Error: No route found for 'admin.{instid}'")
            sys.exit(2)

        result = {
            "admin_url": f"https://{varstr}/maximo"
        }
        json_output = json.dumps(result)
        print(json_output)

    except json.JSONDecodeError as e:
        print(f"Error: Failed to parse JSON: {e}")
        sys.exit(3)

    except subprocess.CalledProcessError as e:
        print(f"Error: Command '{e.cmd}' returned non-zero exit status {e.returncode}")
        sys.exit(4)

    except OSError as e:
        print(f"Error: Failed to execute command: {e}")
        sys.exit(5)


if __name__ == "__main__":
    # get KUBECONFIG containing path from json passed to the command as an argument
    # Read the JSON input from stdin
    input_json = json.loads(sys.stdin.read())

    # get the KUBECONFIG path from the json
    kubeconfig = input_json['KUBECONFIG']

    #capability = sys.argv[1]
    #instanceId = sys.argv[2]    
    #workspaceId = sys.argv[3]
    
    instanceId = "natinst2"
    capability = "manage"
    workspaceId = "wrkid2"
    
    if capability == "core":
        getAdminURLCore(kube_config=kubeconfig, instid=instanceId)
    elif capability == "manage":
        getAdminURLManage(kube_config=kubeconfig, instid=instanceId,workspaceId=workspaceId)
