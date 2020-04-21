#!/bin/bash

#touch docker-compose.yml
docker-compose up -d
docker-compose ps
echo "apache"
curl -l localhost:8081 | grep title
echo "apache tomcat"
curl -l localhost:8080 | grep title
docker-compose stop
docker-compose rm -f