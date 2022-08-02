#!/bin/bash

docker-compose down

docker rm -f webmailserver servermail ns1

docker rmi -f mails webmail dns

docker rmi -f mail-asa_server_mail mail-asa_webmail mail-asa_dns
