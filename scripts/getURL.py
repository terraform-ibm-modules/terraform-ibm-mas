import json
import subprocess

def getAdminURLCore(dep_flavor, instid, wrksid):
    admin_route = subprocess.run([f"oc get route {instid}-admin -n mas-{instid}-core -o json"], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if admin_route.stdout:
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
    else:
        print(f"Unable to fetch MAS Core Admin URL, terminal output : {admin_route.stderr}")

getAdminURLCore(dep_flavor="core", instid="natinst1", wrksid="wrkid1")
