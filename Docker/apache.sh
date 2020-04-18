#!/bin/bash

docker build -t sudoom/apache2 ~/Itransition_DevOps/Docker/Docker_file
docker login docker.io && docker push sudoom/apache2:latest
docker run --name test_apache -p 8081:80 -d sudoom/apache2
sleep 5
curl -l localhost:8081
docker stop test_apache && docker rm test_apache
