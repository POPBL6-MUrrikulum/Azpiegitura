#!/bin/bash

# Inicia Zookeeper
#/home/user/kafka/bin/zookeeper-server-start.sh /home/user/kafka/config/zookeeper.properties &

# Espera a que Zookeeper inicie
sleep 5

# Inicia el servidor Kafka
/home/user/kafka/bin/kafka-server-start.sh /home/user/kafka/config/server.properties
