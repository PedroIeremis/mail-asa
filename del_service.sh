#!/bin/bash

docker rm -f webmailserver servermail ns1

docker rmi -f mails webmail dns
