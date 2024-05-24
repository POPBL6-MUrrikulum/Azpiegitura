
openssl x509 -req -in zerbitzaria.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
-out zerbitzaria.crt -days 3650 -extfile v3_zerbitzaria.ext