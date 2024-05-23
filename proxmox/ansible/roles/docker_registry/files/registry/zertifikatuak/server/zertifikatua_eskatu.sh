# Generar clave privada para la CA
openssl ecparam -name secp521r1 -genkey -noout -out ca.key

# Crear certificado autofirmado para la CA (CA.crt)
openssl req -new -x509 -nodes -days 3650 -key ca.key -out ca.crt \
-subj "/C=ES/ST=Gipuzkoa/L=Arrasate/O=MyCompany/OU=IT/CN=mydomain.com"

# Generar clave privada para el servidor (servidor.key)
openssl ecparam -name secp521r1 -genkey -noout -out zerbitzaria.key

# Crear un certificado de servidor con nombres alternativos de dominio mediante un CSR y firma con la clave privada de la CA.
openssl req -new -key zerbitzaria.key -out zerbitzaria.csr \
-subj "/C=ES/ST=Gipuzkoa/L=Arrasate/O=MyCompany/OU=IT/CN=sub.mydomain.com" \
-addext "subjectAltName = DNS:sub.mydomain.com"