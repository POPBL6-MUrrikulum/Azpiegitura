docker run -d --rm --name registry -p 5000:5000 \
--hostname sub.mydomain.com \
-v ./configuration/config.yaml:/etc/docker/registry/config.yaml \
-v ./zertifikatuak:/etc/docker/registry/zertifikatuak \
-v ./contents:/var/lib/registry \
registry:2.8.3