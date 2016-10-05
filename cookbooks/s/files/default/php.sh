#!/bin/bash
  cd /etc/php5/fpm/
  sed -i '/cgi.fix_pathinfo=1/s/^#//g'  /etc/php5/fpm/php.ini
  sed -i s#cgi.fix_pathinfo=1#cgi.fix_pathinfo=0#g /etc/php5/fpm/php.ini
