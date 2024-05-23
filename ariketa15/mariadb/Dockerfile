ARG version=20240211
FROM debian:bookworm-$version-slim
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
 && apt-get install -y \
    mariadb-server \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV USER mariadb
ENV HOME /home/$USER

RUN groupadd -g 1000 $USER \
 && useradd -u 1000 -g 1000 --create-home --home-dir $HOME $USER \
 && chown -R $USER:$USER $HOME \
 && chown -R $USER:$USER /var/lib/mysql \
 && mkdir -p /var/run/mysqld \
 && chown -R $USER:$USER /var/run/mysqld

WORKDIR $HOME
USER $USER
#ENTRYPOINT [ "mariadbd-safe" ]
ENTRYPOINT [ "mysqld_safe" ]
#CMD ["sh", "-c", "mariadbd-safe && tail -f /dev/null"]