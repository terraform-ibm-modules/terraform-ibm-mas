set -e

function getAdminURL()
{
varstr=$(oc get route -n mas-${var2}-core --no-headers | grep admin.${var2} | awk '{print $2}')
varstr="https://"$varstr""
echo -n "${varstr}" > url.txt
}

var1=$1
var2=$2

getAdminURL


