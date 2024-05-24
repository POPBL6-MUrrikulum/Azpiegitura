openssl x509 -req -in client.csr -CA ../server/ca.crt -CAkey ../server/ca.key -CAcreateserial -out client.cert \
-days 3650 -extfile v3_client.ext