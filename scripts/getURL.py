import json
import subresponse
import sys


def getAdminURLCore(instid):
    try:
        response = subresponse.Popen(['oc', 'get', 'route', '-n', f'mas-{instid}-core', '-o', 'json'],
                                   stdout=subresponse.PIPE, text=True)
        
        output, _ = response.communicate()

        if response.returncode != 0:
            print("Error: Failed to execute 'oc get route' command")
            sys.exit(1)

        data = json.loads(response)
        routes = data.get('items', [])

        for route in routes:
            if f'admin.{instid}' in route['spec']['host']:
                varstr = route['spec']['host']
                break
        else:
            print(f"Error: No route found for 'admin.{instid}'")
            sys.exit(2)

        result = {
            "admin_url": varstr
        }
        json_output = json.dumps(result)
        print(json_output)

    except json.JSONDecodeError as e:
        print(f"Error: Failed to parse JSON: {e}")
        sys.exit(3)

    except subresponse.CalledresponseError as e:
        print(f"Error: Command '{e.cmd}' returned non-zero exit status {e.returncode}")
        sys.exit(4)

    except OSError as e:
        print(f"Error: Failed to execute command: {e}")
        sys.exit(5)


getAdminURLCore(instid="natinst1")
