# Usa una imagen base Debian


FROM debian:bookworm-20240211-slim

LABEL Name="cassandra" \
      Version="1.0.0" \
      Description="" \
      URL="https://nifi.apache.org/"


# Definimos variables de argumento para la versión de Java y Hadoop
ARG java_version=8u402-ga-2_amd64
ARG hadoop_version=3.3.6
ARG debian_snapshot_version=20240220T150546Z

# Establecemos la variable de entorno JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Establecemos el modo non-interactive para evitar preguntas durante la instalación
ENV DEBIAN_FRONTEND noninteractive

# Instalamos las dependencias de Hadoop, como ssh-server y gosu
RUN apt-get update \
 && apt-get install -y \
    openssh-server \
    gosu \
    sudo \
    curl \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && apt-get clean 

# Descargamos e instalamos las versiones específicas de OpenJDK para evitar errores
RUN echo 'deb http://deb.debian.org/debian/ sid main' >> /etc/apt/sources.list && apt-get update && apt-get install -y openjdk-8-jdk

# Crear usuario 'user' con contraseña 'user' y SSH, y agregarlo al grupo sudo
RUN useradd -ms /bin/bash user && \
    echo "user:user" | chpasswd && \
    echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/user 


# Download Apache Cassandra keys and add the repository
RUN echo "deb [signed-by=/etc/apt/keyrings/apache-cassandra.asc] https://debian.cassandra.apache.org 41x main" >> /etc/apt/sources.list.d/cassandra.sources.list \
    && curl -o /etc/apt/keyrings/apache-cassandra.asc https://downloads.apache.org/cassandra/KEYS \
    && apt-get update \
    && apt-get install cassandra -y && apt-get clean 

# Change ownership of Cassandra data directory and configuration files
RUN chown -R user:user /var/lib/cassandra /etc/cassandra /var/log/cassandra  \
 && chmod 777 /var/lib/cassandra \
 && chmod 777 /var/log/cassandra \
 && chmod 777 /etc/cassandra/* \
 && sed -i 's/rpc_address: localhost/rpc_address: 0.0.0.0/' /etc/cassandra/cassandra.yaml \
 && sed -i 's/# broadcast_rpc_address: 1.2.3.4/broadcast_rpc_address: 10.128.0.16/' /etc/cassandra/cassandra.yaml 

WORKDIR /home/user
USER user
# iniciar cassandra
EXPOSE 9042 7000
CMD ["cassandra", "-f"]