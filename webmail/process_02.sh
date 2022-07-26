#!/bin/bash
cd /var/www/html/

mkdir webmail

chmod 755 -R webmail/

cd webmail
chown -R www-data:www-data data

/etc/init.d/apache2 restart