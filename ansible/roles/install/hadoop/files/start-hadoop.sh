#!/bin/bash

# Función para verificar si el formato de namenode ya se ha realizado
check_namenode_format() {
    if [ -f /opt/hadoop/hadoop_tmp/hdfs/namenode/current/VERSION ]; then
        echo "Namenode format already done, skipping."
        return 0
    else
        return 1
    fi
}

# Función para formatear el namenode si es necesario
format_namenode() {
    if check_namenode_format; then
        return
    fi

    echo "Formatting namenode..."
    $HADOOP_HOME/bin/hdfs namenode -format -y
}

# Función para iniciar SSH y Hadoop
start_services() {
    echo "Starting SSH..."
    sudo /etc/init.d/ssh start
    echo "Starting Hadoop services..."
    $HADOOP_HOME/sbin/start-all.sh
}

# Ejecutar las funciones necesarias
format_namenode
start_services
