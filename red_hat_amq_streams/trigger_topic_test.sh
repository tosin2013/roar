#!/bin/bash

mkdir -p ~/workspace && cd ~/workspace
git clone https://github.com/hguerrero/amq-examples.git
cd amq-examples/camel-kafka-demo/

echo "Extracting the public certificate of the broker certification authority."
oc extract secret/my-cluster-cluster-ca-cert --keys=ca.crt --to=- > src/main/resources/ca.crt

echo "Importing the trusted cert to a keystore."
keytool -import -trustcacerts -alias root -file src/main/resources/ca.crt -keystore src/main/resources/keystore.jks -storepass password -noprompt


echo "Running Red Hat Fuse application to send and receive messages to the Kafka cluster..."
sleep -n 5s
mvn -Drun.jvmArguments="-Dbootstrap.server=`oc get routes my-cluster-kafka-bootstrap -o=jsonpath='{.status.ingress[0].host}{"\n"}'`:443" clean package spring-boot:run
