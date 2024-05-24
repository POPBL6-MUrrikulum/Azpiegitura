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
    sudo \
    wget \
    nano \
    tree \
    lsof \
    iproute2 \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && echo 'deb http://deb.debian.org/debian/ sid main' >> /etc/apt/sources.list \
 && apt update --fix-missing && apt upgrade -y && apt install -y \
    openjdk-8-jdk

RUN wget https://downloads.apache.org/lucene/solr/8.11.3/solr-8.11.3.tgz \
&& tar xzf solr-8.11.3.tgz \
&& bash solr-8.11.3/bin/install_solr_service.sh solr-8.11.3.tgz

EXPOSE 8983

WORKDIR /opt/solr
USER solr

# Iniciamos los servicios SSH y Hadoop
CMD ["sh", "-c", "./bin/solr start ; tail -f /dev/null"]
# CMD ["tail", "-f", "/dev/null"]