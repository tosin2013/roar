# Red Hat AMQ Streams Quick Start

Below is a collection of links and examples to Red Hat AMQ Streams on OpenShift.
[mycluster]: https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "My Red Hat AMQ Streams Cluster"

## Concepts
**Red Hat AMQ Streams is a massively-scalable, distributed, and high-performance data streaming
platform based on the Apache Zookeeper and Apache Kafka projects. It consists of the following main
components:***  
 * **Zookeeper**
  * Service for highly reliable distributed coordination.
 * **Kafka Broker**
  * Messaging broker responsible for delivering records from producing clients to consuming clients.
 * **Kafka Connect**
  * A toolkit for streaming data between Kafka brokers and other systems using Connector plugins.
 * **Kafka Consumer and Producer APIs**
  * Java based APIs for producing and consuming messages to / from Kafka brokers.
 * **Kafka Streams API**
  * API for writing stream processor applications  

**[AMQ Streams](https://access.redhat.com/documentation/en-us/red_hat_amq/7.2/html/using_amq_streams_on_openshift_container_platform/overview-str) is based on Apache Kafka 2.0.0 and consists of three main components:**

  * Cluster Operator
   * Responsible for deploying and managing Apache Kafka clusters within OpenShift cluster.
  * Topic Operator
   * Responsible for managing Kafka topics within a Kafka cluster running within OpenShift cluster.
  * User Operator
   * Responsible for managing Kafka users within a Kafka cluster running within OpenShift cluster.

## How it works
  * Messages are sent to and received  from a topic
   * Topics are split into one or more partitions (aka shards)
   * All actual work is done on partition level, topic is just a virtual object.
  * Each message is written only into a one selected partition
   * Partitioning is usually done based on the message key
   * Messages ordering with the partition is fixed.
  * Retention
   * Based on size / message age
   * Compacted based on message key

## Usage
 * Create AMQ Streams Operating on minishift
 ```
 ./amq_streams.sh
 ```
* Create cluster and topic
```
./create_kafka_cluster.sh
```
* Send a receive messages from a topic
```
./trigger_topic_test.sh
```
* To cleanup files used for amq steams
```
./clean
```
* To cleanup minishift deployment
```
../delete_minishift.sh
```

## Tested on the following
 * MACOS
## Helpful Links
 * [Introducing AMQ Streams—data streaming with Apache Kafka](https://www.redhat.com/de/about/videos/summit-2018-introducing-amq-streams-data-streaming-apache-kafka)
 * [Installing and deploying AMQ Broker on OpenShift Container Platform](https://access.redhat.com/documentation/en-us/red_hat_amq/7.2/html-single/deploying_amq_broker_on_openshift_container_platform/index#install-deploy-ocp-broker-ocp)
 * [Red Hat AMQ Streams 1.0 OpenShift Container Images](https://github.com/jboss-container-images/amqstreams-1-openshift-image)  
 * [How to run Kafka on Openshift, the enterprise Kubernetes, with AMQ Streams](https://developers.redhat.com/blog/2018/10/29/how-to-run-kafka-on-openshift-the-enterprise-kubernetes-with-amq-streams/)  
 * https://developers.redhat.com/products/amq/hello-world/#fndtn-amq-streams
 * [Using AMQ Streams on Red Hat Enterprise
 Linux (RHEL)](https://access.redhat.com/documentation/en-us/red_hat_amq/7.2/pdf/using_amq_streams_on_red_hat_enterprise_linux_rhel/Red_Hat_AMQ-7.2-Using_AMQ_Streams_on_Red_Hat_Enterprise_Linux_RHEL-en-US.pdf)  
