#!/bin/bash

sudo docker run --name docker-nginx -v `pwd`/nginx/etc:/etc/nginx -p 8080:80 -d nginx