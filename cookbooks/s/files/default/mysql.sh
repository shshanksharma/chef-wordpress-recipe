#!/bin/bash
  mysql -u root -e "CREATE DATABASE wordpres;"
  mysql -u root -e "CREATE USER wordpressuse@localhost IDENTIFIED BY 'password';"
  mysql -u root -e "GRANT ALL PRIVILEGES ON wordpres.* TO wordpressuse@localhost;"
  mysql -u root -e "FLUSH PRIVILEGES;"

