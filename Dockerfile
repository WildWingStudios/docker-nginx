# Wild Wing Studios - Nginx and Wordpress 
FROM debian:jessie

EXPOSE 80

MAINTAINER Brennen Smith <brennen@wildwingstudios.com>

# Get Deps
RUN apt-get update && apt-get -y install \
    unzip \
    curl  \
    nginx-light

# Clean Default Confs
RUN rm -rf /var/www/html/ /etc/nginx/sites-enabled/default

# Get Wordpress Core
ENV WPVER 4.2.2

RUN mkdir -p /var/www \
    && curl https://wordpress.org/wordpress-${WPVER}.tar.gz | tar -xz --exclude="wp-content" -C /var/www/ \
    && chown -R www-data:www-data /var/www/wordpress

# Cleanup 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add WP-Config

# Add Nginx.conf
COPY lib/wordpress /etc/nginx/sites-enabled/

# Run NGINX
