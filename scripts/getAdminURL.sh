#!/bin/bash
set -e

function getAdminURL()
{
varstr=$(oc get route -n mas-"${var1}"-core --no-headers | grep admin."${var1}" | awk '{print $2}')
varstr="https://$varstr"
echo -n "${varstr}" > url.txt
}

var1=$1

getAdminURL
