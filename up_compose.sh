#!/bin/bash

echo "Altere no arquivo que abrirá o que tem 'SUAREDELOCAL' pela sua rede local com o barramento de máscara <Tecle Enter para prosseguir>" ; read
cd server_mail/smtp_postfix
nano main.cf

echo "Digite seu IP, para o DNS> " ; read ip
echo "nameserver $ip"

echo "travando"
read
cd ..
docker-compose up -d

docker exec servermails /etc/init.d/postfix restart
docker exec servermails /etc/init.d/dovecot restart

docker exec webserver ./process_02.sh

docker exec ns1 echo "nameserver $ip" > /etc/resolv.conf
