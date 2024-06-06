# Usamos la imagen base de Debian Bookworm
FROM debian:bookworm-20240211-slim

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
    nano \
    iputils-ping \
    gosu \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && echo 'deb http://deb.debian.org/debian/ sid main' >> /etc/apt/sources.list \
 && apt update --fix-missing && apt upgrade -y && apt install -y \
    openjdk-8-jdk   \
                    \
 && useradd -r user -m -d /opt/user --shell /bin/bash \
 && echo "user:user" | sudo chpasswd \
 && echo 'user ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/user

WORKDIR /opt/user
USER user

RUN ssh-keygen -q -t rsa -N "" -f /opt/user/.ssh/id_rsa \
 && cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys 


EXPOSE 9870 8020 8032 50010 50020 9866 22 9000

# Iniciamos los servicios SSH y Hadoop
#CMD ["sh", "-c", "tail -f /dev/null"]
CMD ["tail", "-f", "/dev/null"]