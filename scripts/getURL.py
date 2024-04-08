import json
import subprocess

def getAdminURLCore(dep_flavor, instid, wrksid):
    admin_route = subprocess.run([f"oc get route {instid}-admin -n mas-{instid}-core -o json"], shell=True, capture_output=True, text=True)
    json_res = json.loads(admin_route.stdout)
    admin_host = json_res.get("spec").get("host")
    admin_url = f"https://{admin_host}"
    data = {
        "admin_url": admin_url
        }
    # Encode the dictionary into JSON format
    json_output = json.dumps(data)

    # Print the JSON output
    print(json_output)

getAdminURLCore(dep_flavor="core", instid="natinst1", wrksid="wrkid1")
