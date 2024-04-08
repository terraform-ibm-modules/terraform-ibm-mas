import json
import subprocess
import sys


def getAdminURLCore(instid):
    try:
        process = subprocess.Popen(['oc', 'get', 'route', '-n', f'mas-{instid}-core', '-o', 'json'],
                                   stdout=subprocess.PIPE, text=True)
        
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


getAdminURLCore(instid="natinst1")
