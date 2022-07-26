FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y \
    apache2 \
    iputils-ping \
    nano
#    php

#RUN ln -fs /usr/share/zoneinfo/America/Bahia && dpkg-reconfigure -f nonintractive tzdata
RUN apt-get upgrade -y

COPY process_02.sh .

EXPOSE 80
CMD tail -F /dev/null