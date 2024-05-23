ARG version=20240211

FROM debian:bookworm-$version-slim

ENV DEBIAN_FRONTEND noninteractive


# ELASTICSEARCH
# -------------
ARG elastic_version=8.13.1

ARG USER=elastic
ARG HOME=/home/$USER

ENV ELASTIC_HOME /opt/elastic
ENV PATH $PATH:$ELASTIC_HOME/bin


# Install prerequisites
RUN apt-get update && apt-get install -y \
    curl \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

# Add elasticsearch user
RUN groupadd -g 1000 $USER \
 && useradd -u 1000 -g 1000 --create-home --home-dir $HOME $USER \
 && chown -R $USER:$USER $HOME


# Install Elasticsearch
#RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$elastic_version-linux-x86_64.tar.gz \
RUN curl -k -o elasticsearch-$elastic_version-linux-x86_64.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$elastic_version-linux-x86_64.tar.gz \
  ; tar -xzf elasticsearch-$elastic_version-linux-x86_64.tar.gz -C /opt/ \
  ; mv /opt/elasticsearch-$elastic_version $ELASTIC_HOME \
  ; rm elasticsearch-$elastic_version-linux-x86_64.tar.gz \
  ; chown -R $USER:$USER $ELASTIC_HOME

# Expose ports
EXPOSE 9200 9300

WORKDIR $ELASTIC_HOME
USER $USER
# Start Elasticsearch when the container starts
CMD ["bin/elasticsearch"]

















# # Usamos la imagen base de Debian Bookworm
# ARG version=20240211
# FROM debian:bookworm-$version-slim

# # Establecemos el modo non-interactive para evitar preguntas durante la instalación
# ENV DEBIAN_FRONTEND noninteractive  
# # Establecemos la variable de entorno JAVA_HOME


# # Instalamos las dependencias 
# # Descargamos e instalamos las versiones específicas de OpenJDK para evitar errores
# RUN apt-get update && apt upgrade -y && apt-get install -y \
#     sudo \
#     wget \
#     nano \
#     tree \
#     gpg \
#     curl \
#     iproute2 \
#     --no-install-recommends 

# RUN curl -fsSL 'https://artifacts.elastic.co/GPG-KEY-elasticsearch' | gpg --dearmor -o /usr/share/keyrings/elastic.gpg 
# RUN echo "deb [signed-by=/usr/share/keyrings/elastic.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list \
# && apt update \
# && apt install elasticsearch \
# && sed -i 's/#network.host: 192.168.0.1/network.host: localhost/'  /etc/elasticsearch/elasticsearch.yml

# EXPOSE 9200

# # Iniciamos los servicios SSH y Hadoop
# CMD ["sh", "-c", "/etc/init.d/elasticsearch start ; tail -f /dev/null"]
# # CMD ["tail", "-f", "/dev/null"]