#!/bin/bash

docker pull nginx
mkdir -p `pwd`/nginx/etc
docker run --name docker-nginx -v `pwd`/nginx/etc:/etc/nginx -p 8080:80 -d nginx
sleep 10
curl -l localhost:8080 | grep title
docker stop docker-nginx
