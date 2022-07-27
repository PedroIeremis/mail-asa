#!/bin/bash

echo "Altere no final do arquivo que abrirá onde tem 'SUAREDELOCAL' pela sua rede local, com o barramento de máscara."
echo "Tecle <Enter> para prosseguir> " ; read
cd server_mails/smtp_postfix
nano main.cf

echo "Seu IP> " ; read ip
pos1=$(echo $ip | cut -d "." -f 1)
pos2=$(echo $ip | cut -d "." -f 2)
pos3=$(echo $ip | cut -d "." -f 3)
rev=$(echo $ip | cut -d "." -f 4)
res=$(echo "$pos3.$pos2.$pos1")

echo "-------------------------------------------------------------"
echo "SUAS CONFIGURAÇÕES"
echo "IP: $ip"
echo "Último valor do IP: $rev"
echo "Rede de forma reversa: $res"
echo "Se corretas, tecle <Enter>, se erradas <Control+C> e refaça"
echo "-------------------------------------------------------------" ; read

cd ../../dns
docker build -t dns .
cd primary
sed -i "s/primary/$ip/" db.ac.asa.br
sed -i "s/reverse1/$rev/" db.reverse.ac.asa.br
sed -i "s/reverserede/$res/" named.conf.default-zones
wrk=$(pwd)
docker run -d -p $ip:53:53/udp -p $ip:53:53/tcp --name ns1 --hostname dns-ns1 -v "$wrk"/:/etc/bind --dns $ip dns

echo "-------------------------------------------------------------"
echo " - - - - - - - - - - - DNS EM EXECUÇÃO - - - - - - - - - - - "
echo "-------------------------------------------------------------"

cd ../../server_mails
docker build -t mails .
docker run -d --name servermail -p 25:25 -p 143:143 mails

echo "-------------------------------------------------------------"
echo " - - - - - - - SERVIDORES DE EMAIL EM EXECUÇÃO - - - - - - - "
echo "-------------------------------------------------------------"

docker exec servermail /etc/init.d/postfix restart
docker exec servermail /etc/init.d/dovecot restart

cd ../webmail
docker build -t webmail .
cd rainloop
wrk2=$(pwd)
docker run -d --name webmailserver -p 80:80 -v "$wrk2"/:/var/www/html/rainloop webmail

echo "-------------------------------------------------------------"
echo " - - - - - - - - - - WEBMAIL EM EXECUÇÃO - - - - - - - - - - "
echo "-------------------------------------------------------------"

docker exec webmailserver ./process_02.sh
