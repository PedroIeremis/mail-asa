#!/bin/bash

docker build -t teste .

docker run -d --name teste teste

docker exec teste /etc/init.d/postfix restart

docker exec teste /etc/init.d/dovecot restart
