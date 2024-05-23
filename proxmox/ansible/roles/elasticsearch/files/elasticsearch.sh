apt update && apt upgrade -y
apt install -y openssh-server gpg sudo  curl wget nano tree iproute2

curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic.gpg
echo "deb [signed-by=/usr/share/keyrings/elastic.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
apt update

apt install elasticsearch

/etc/init.d/elasticsearch start


sed -i 's/#network.host: 192.168.0.1/network.host: localhost/'  /etc/elasticsearch/elasticsearch.yml
# pon contra barras si quieres poner paths
sed -i 's/#network.host: /network.host: \/path\/to\/file/'  /etc/elasticsearch/elasticsearch.yml

expose 9200
/etc/init.d/elasticsearch stop
/etc/init.d/elasticsearch star