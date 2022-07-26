#!/bin/bash

docker build -t webmail .

cd rainloop

dir=$(pwd)
docker run -d --name webserver -p 80:80 -v "$dir"/:/var/www/html/rainloop webmail

docker exec webserver ./process_02.sh