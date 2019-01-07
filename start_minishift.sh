#!/bin/bash
# https://docs.okd.io/latest/minishift/using/basic-usage.html#basic-usage-overview

echo "Launching mimishift"
minishift start || exit $?
eval $(minishift oc-env)
eval $(minishift docker-env)
echo "Logging in to OpenShift as a cluster administrator"
oc login -u system:admin || exit $?


#oc policy add-role-to-user cluster-admin developer
