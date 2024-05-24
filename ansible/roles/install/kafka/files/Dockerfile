# Usa una imagen base Debian
FROM debian:bookworm-20240211-slim

LABEL Name="nifi" \
      Version="2.0.0-M3" \
      Description="Apache NiFi es un sistema fácil de usar, poderoso y confiable para procesar y distribuir datos." \
      URL="https://nifi.apache.org/"
      
# Actualiza e instala las dependencias necesarias
RUN apt-get update && apt-get install -y \
    wget \
    default-jre \
    default-jdk \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Variables de entorno para configurar Kafka
# Establecemos el modo non-interactive para evitar preguntas durante la instalación
ENV DEBIAN_FRONTEND noninteractive

# Crear usuario 'user' con contraseña 'user' y SSH, y agregarlo al grupo sudo
RUN useradd -ms /bin/bash user && \
    echo "user:user" | chpasswd && \
    echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/user 

WORKDIR /home/user
USER user

# Descarga Apache Kafka y descomprime
RUN wget https://archive.apache.org/dist/kafka/3.5.1/kafka_2.13-3.5.1.tgz \
&& mkdir kafka && cd kafka \
&& tar -xvzf /home/user/kafka_2.13-3.5.1.tgz --strip 1 \
&& echo "delete.topic.enable = true" >> /home/user/kafka/config/server.properties \
&& sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=172.18.0.1:2181/'  /home/user/kafka/config/server.properties

COPY zookeeper.service /etc/systemd/system/zookeeper.service
COPY kafka.service /etc/systemd/system/kafka.service

COPY start-kafka.sh /usr/bin/start-kafka.sh 
RUN sudo chmod +x /usr/bin/start-kafka.sh

# Configurar el inicio de Kafka
CMD ["/usr/bin/start-kafka.sh"]

# sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \ buscar, y reemplazar