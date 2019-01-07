#!/bin/bash
export PROJECT_NAME="myproject"
export CLUSTER_NAME='my-cluster'
export KAFKA_COUNT=3
export KAFKA_TOPIC="my-topic"
export ZOOKEEPER_COUNT=3
export PARTITION_NUMBER=3
export REPLICA_NUMBER=3

if [[ -d  ~/workspace/amqsteams ]]; then
     cd ~/workspace/amqsteams
     rm ${CLUSTER_NAME}-config.yml && rm  ${KAFKA_TOPIC}-custom-resource.yml
else
    echo "~/workspace/amqsteams directory not found"
    exit 1
fi

 oc login -u developer
 oc project $PROJECT_NAME-project


cat <<YAML >> ${CLUSTER_NAME}-config.yml
apiVersion: kafka.strimzi.io/v1alpha1
kind: Kafka
metadata:
  name: ${CLUSTER_NAME}
spec:
  kafka:
    replicas: ${KAFKA_COUNT}
    listeners:
      external:
        type: route
    storage:
      type: ephemeral
  zookeeper:
    replicas: ${ZOOKEEPER_COUNT}
    storage:
       type: ephemeral
  entityOperator:
    topicOperator: {}
YAML

oc create -f ${CLUSTER_NAME}-config.yml || exit $?

cat <<YAML >> ${KAFKA_TOPIC}-custom-resource.yml
apiVersion: kafka.strimzi.io/v1alpha1
kind: KafkaTopic
metadata:
  name: ${KAFKA_TOPIC}
  labels:
    strimzi.io/cluster: ${CLUSTER_NAME}
spec:
  partitions: ${PARTITION_NUMBER}
  replicas: ${REPLICA_NUMBER}
YAML

 oc create -f ${KAFKA_TOPIC}-custom-resource.yml || exit $?
