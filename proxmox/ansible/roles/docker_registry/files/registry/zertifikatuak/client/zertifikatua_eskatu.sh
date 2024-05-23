openssl ecparam -name secp521r1 -genkey -noout -out client.key

openssl req -new -key client.key -out client.csr \
-subj "/C=ES/ST=Gipuzkoa/L=Arrasate/O=MyCompany/OU=IT/CN=*"