#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
fi

docker run -d -P -e VIRTUAL_HOST=$1 --name $1  -v /var/www/wordpress/wp-content/:/var/htdocs/$1/wp-content/ wildwingstudios/nginx-wordpress
