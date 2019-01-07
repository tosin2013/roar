#!/bin/bash
# This guide describes how to install, configure, and manage Red Hat AMQ Streams to build a large-scale messaging network.
# https://developers.redhat.com/blog/2018/10/29/how-to-run-kafka-on-openshift-the-enterprise-kubernetes-with-amq-streams/
# https://access.redhat.com/documentation/en-us/red_hat_amq/7.2/html-single/using_amq_streams_on_openshift_container_platform/index
export PROJECT_NAME="myproject"


minishift profile set streams
minishift config set cpus 2
minishift config set memory 8192

minishift config set vm-driver virtualbox

minishift addons disable anyuid

../start_minishift.sh || exit $?

mkdir -p ~/workspace/amqsteams && cd ~/workspace/amqsteams
unzip ~/Downloads/install_and_examples.zip

oc login -u system:admin

kubectl create -f ~/Downloads/12216224_takinosh-secret.yaml --namespace=myproject

oc project $PROJECT_NAME || exit $?
oc apply -f install/cluster-operator -n $PROJECT_NAME || exit $?

oc new-project ${PROJECT_NAME}-project || exit $?
oc adm policy add-role-to-user admin developer -n ${PROJECT_NAME}-project || exit $?

oc set env deploy/strimzi-cluster-operator STRIMZI_NAMESPACE=${PROJECT_NAME},${PROJECT_NAME}-project -n ${PROJECT_NAME}
oc apply -f install/cluster-operator/020-RoleBinding-strimzi-cluster-operator.yaml -n ${PROJECT_NAME}-project
oc apply -f install/cluster-operator/032-RoleBinding-strimzi-cluster-operator-topic-operator-delegation.yaml -n ${PROJECT_NAME}-project
oc apply -f install/cluster-operator/031-RoleBinding-strimzi-cluster-operator-entity-operator-delegation.yaml -n ${PROJECT_NAME}-project

echo "Creating the new Cluster Role strimzi-admin."
cat << EOF | oc create -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: strimzi-admin
rules:
- apiGroups:
  - "kafka.strimzi.io"
  resources:
  - kafkas
  - kafkaconnects
  - kafkaconnects2is
  - kafkamirrormakers
  - kafkausers
  - kafkatopics
  verbs:
  - get
  - list
  - watch
  - create
  - delete
  - patch
  - update
EOF

oc adm policy add-cluster-role-to-user strimzi-admin developer || exit $?
