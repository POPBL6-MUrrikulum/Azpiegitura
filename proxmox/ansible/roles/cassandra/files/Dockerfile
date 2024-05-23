# Usa una imagen base Debian

FROM debian:bookworm-20240211-slim

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
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
    && apt-get install cassandra -y

# Change ownership of Cassandra data directory and configuration files
RUN chown -R user:user /var/lib/cassandra /etc/cassandra \
 && chmod 755 /var/lib/cassandra \
 && chmod 644 /etc/cassandra/*

WORKDIR /home/user
USER user
# iniciar cassandra
CMD ["cassandra", "-f"]