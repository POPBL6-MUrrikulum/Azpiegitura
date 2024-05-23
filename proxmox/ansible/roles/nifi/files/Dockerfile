# Declaramos el argumento de la versión antes de la instrucción FROM
FROM debian:bookworm-20240211-slim

# Añadimos etiquetas recomendadas
LABEL Name="nifi" \
      Version="2.0.0-M3" \
      Description="Apache NiFi es un sistema fácil de usar, poderoso y confiable para procesar y distribuir datos." \
      URL="https://nifi.apache.org/"

# Establecemos el modo non-interactive para evitar preguntas durante la instalación
ENV DEBIAN_FRONTEND noninteractive  
# Establecemos la variable de entorno JAVA_HOME

# Instalamos las dependencias 
# Descargamos e instalamos las versiones específicas de OpenJDK para evitar errores
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    unzip \
    gnupg \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && echo 'deb http://deb.debian.org/debian/ sid main' >> /etc/apt/sources.list \
 && apt update --fix-missing && apt upgrade -y && apt install -y \
    openjdk-8-jdk   \
                    \
 && mkdir /opt/user && apt-get clean

WORKDIR /opt/user
USER root

RUN wget https://downloads.apache.org/nifi/KEYS -O KEYS\
 && gpg --import KEYS \
 && wget https://downloads.apache.org/nifi/1.26.0/nifi-1.26.0-bin.zip \
 && wget https://downloads.apache.org/nifi/1.26.0/nifi-1.26.0-bin.zip.asc \
 && gpg --verify nifi-1.26.0-bin.zip.asc nifi-1.26.0-bin.zip \
 && unzip nifi-1.26.0-bin.zip && rm nifi-1.26.0-bin.zip && rm nifi-1.26.0-bin.zip.asc

# opcion 2: copiar hadoop ya descargado 
# COPY  hadoop-.4.0.tar.gz .
# RUN   tar -xzvf hadoop-3.4.0.tar.gz -C /opt/hadoop --strip-components=1 && rm hadoop-3.4.0.tar.gz
# Establecemos la variable de entorno JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

EXPOSE 8080


RUN JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 /opt/user/nifi-1.26.0/bin/nifi.sh install && /opt/user/nifi-1.26.0/bin/nifi.sh start && /opt/user/nifi-1.26.0/bin/nifi.sh stop
# 
RUN sed -i 's/nifi.remote.input.secure=true/ nifi.remote.input.secure=false /' /opt/user/nifi-1.26.0/conf/nifi.properties \
&& sed -i 's/nifi.web.https.host=127.0.0.1/ nifi.web.https.host= /'            /opt/user/nifi-1.26.0/conf/nifi.properties \
&& sed -i 's/nifi.web.https.port=8443/ nifi.web.https.port= /'                 /opt/user/nifi-1.26.0/conf/nifi.properties \  
&& sed -i 's/nifi.web.http.host=/ nifi.web.http.host=0.0.0.0 /'                /opt/user/nifi-1.26.0/conf/nifi.properties \
&& sed -i 's/nifi.web.http.port=/ nifi.web.http.port=8080 /'                   /opt/user/nifi-1.26.0/conf/nifi.properties 

#CMD ["sh", "-c", "service nifi start; tail -f /dev/null"]
#CMD ["sh", "-c", "service nifi start && exec tail -f /opt/user/nifi/logs/nifi-app.log"]
CMD ["sh", "-c", "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 && /opt/user/nifi-1.26.0/bin/nifi.sh start ; tail -f /dev/null"]