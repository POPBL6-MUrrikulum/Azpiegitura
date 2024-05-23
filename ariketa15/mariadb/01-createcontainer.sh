#LEHENIK ETA BEHIN EDUKI DOCKERFILEA

docker build -t mariadb .

docker run -d --rm --name mariadb --hostname mariadb mariadb

docker cp mariadb:/var/lib/mysql /root/transakzioak/mysql

docker kill mariadb

chmod -R 777 mysql/

docker run -d --rm --name mariadb --hostname mariadb -v /root/transakzioak/mysql:/var/lib/mysql mariadb

docker exec -u 0 -it mariadb bash
