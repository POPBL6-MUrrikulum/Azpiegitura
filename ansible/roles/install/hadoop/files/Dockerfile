# Usamos la imagen base de Debian Bookworm
ARG version=20240211
FROM debian:bookworm-$version-slim

# Establecemos el modo non-interactive para evitar preguntas durante la instalación
ENV DEBIAN_FRONTEND noninteractive  
# Establecemos la variable de entorno JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Instalamos las dependencias 
# Descargamos e instalamos las versiones específicas de OpenJDK para evitar errores
RUN apt-get update && apt upgrade -y && apt-get install -y \
    openssh-server  \
    sudo \
    wget \
    gosu \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && echo 'deb http://deb.debian.org/debian/ sid main' >> /etc/apt/sources.list \
 && apt update --fix-missing && apt upgrade -y && apt install -y \
    openjdk-8-jdk   \
                    \
 && useradd -r hadoop -m -d /opt/hadoop --shell /bin/bash \
 && echo "hadoop:hadoop" | sudo chpasswd \
 && echo 'hadoop ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/hadoop

WORKDIR /opt/hadoop
USER hadoop

RUN ssh-keygen -q -t rsa -N "" -f /opt/hadoop/.ssh/id_rsa \
 && cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys 

# opcion 1: descargar hadoop de internet
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.0/hadoop-3.4.0.tar.gz -O hadoop.tar.gz \
 && tar -xzvf hadoop.tar.gz -C /opt/hadoop --strip-components=1 && rm hadoop.tar.gz 
# opcion 2: copiar hadoop ya descargado 
# COPY  hadoop-3.4.0.tar.gz .
# RUN   tar -xzvf hadoop-3.4.0.tar.gz -C /opt/hadoop --strip-components=1 && rm hadoop-3.4.0.tar.gz

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    HADOOP_HOME=/opt/hadoop \
    PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin \
    HADOOP_MAPRED_HOME=$HADOOP_HOME \
    HADOOP_COMMON_HOME=$HADOOP_HOME \
    HADOOP_HDFS_HOME=$HADOOP_HOME \
    YARN_HOME=$HADOOP_HOME \
    HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native \
    HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"

#RUN sed -i 's/# export JAVA_HOME=/export JAVA_HOME=\/usr\/lib\/jvm\/java-8-openjdk-amd64/' ~/etc/hadoop/hadoop-env.sh \
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64'               >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo 'export HADOOP_HOME=/opt/hadoop'                                >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo 'export PATH=$PATH:$HADOOP_HOME/bin'                            >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo 'export PATH=$PATH:$HADOOP_HOME/sbin'                           >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo 'export HADOOP_MAPRED_HOME=$HADOOP_HOME'                        >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo 'export HADOOP_COMMON_HOME=$HADOOP_HOME'                        >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo 'export HADOOP_HDFS_HOME=$HADOOP_HOME'                          >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo 'export YARN_HOME=$HADOOP_HOME'                                 >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo 'export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native'   >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo 'export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"'     >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
&& echo '\
<configuration>\n\
    <property>\n\
        <name>fs.default.name</name>\n\
        <value>hdfs://localhost:9000</value>\n\
    </property>\n\
</configuration>' > /opt/hadoop/etc/hadoop/core-site.xml \
&&  echo '\
<configuration>\n\
    <property>\n\
        <name>dfs.replication</name>\n\
        <value>1</value>\n\
    </property>\n\
    <property>\n\
        <name>dfs.namenode.name.dir</name>\n\
        <value>file:/opt/hadoop/hadoop_tmp/hdfs/namenode</value>\n\
    </property>\n\
    <property>\n\
        <name>dfs.datanode.data.dir</name>\n\
        <value>file:/opt/hadoop/hadoop_tmp/hdfs/datanode</value>\n\
    </property>\n\
</configuration>' > /opt/hadoop/etc/hadoop/hdfs-site.xml \
&& echo '\
<configuration>\n\
    <property>\n\
        <name>yarn.nodemanager.aux-services</name>\n\
        <value>mapreduce_shuffle</value>\n\
    </property>\n\
    <property>\n\
        <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>\n\
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>\n\
    </property>\n\
</configuration>' > /opt/hadoop/etc/hadoop/yarn-site.xml \
&& echo '\
<configuration>\n\
    <property>\n\
        <name>mapreduce.framework.name</name>\n\
        <value>yarn</value>\n\
    </property>\n\
</configuration>' > /opt/hadoop/etc/hadoop/mapred-site.xml \
&& mkdir -p /opt/hadoop/hadoop_tmp/hdfs/{namenode,datanode}

EXPOSE 9000 8088 8042 9870 22
COPY start-hadoop.sh .
RUN  sudo chown hadoop start-hadoop.sh && sudo chmod +777 start-hadoop.sh

# Iniciamos los servicios SSH y Hadoop
CMD ["sh", "-c", "/opt/hadoop/start-hadoop.sh ; tail -f /dev/null"]
# CMD ["tail", "-f", "/dev/null"]
