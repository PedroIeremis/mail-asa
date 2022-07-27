#!/bin/bash

docker rm -f webmailserver servermail ns1

docker rmi -f mails webmail dns

docker rmi -f mail-asa_mails mail-asa_webmail mail-asa_dns
