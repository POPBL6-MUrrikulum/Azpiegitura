FROM zookeeper:3.9.2-jre-17

LABEL Name="zookeeper" \
      Version="3.9.2" \
      Description="Zookeeper es un servicio centralizado para el mantenimiento de información de configuración, nombramiento, proporcionando sincronización distribuida y servicios de agrupación." \
      URL="https://zookeeper.apache.org/"

ENV DEBIAN_FRONTEND noninteractive 
WORKDIR /apache-zookeeper-3.9.2-bin/
RUN apt-get update && apt install nano && apt-get clean && mkdir -p /data /datalog

EXPOSE 2181 2888 3888
CMD ["zkServer.sh", "start-foreground"]



#RUN echo 'tickTime=2000 '                >> conf/zoo.cfg \
#    echo 'initLimit=10'                  >> conf/zoo.cfg \ 
#    echo 'syncLimit=5'                   >> conf/zoo.cfg \ 
#    echo 'dataDir=/data'                 >> conf/zoo.cfg \ 
#    echo 'clientPort=2181'               >> conf/zoo.cfg \ 
#    echo 'server.1=10.0.2.10:2888:3888'  >> conf/zoo.cfg \ 
#    echo 'server.2=10.0.2.11:2888:3888'  >> conf/zoo.cfg