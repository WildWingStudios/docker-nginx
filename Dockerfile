# Wild Wing Studios - Nginx and Wordpress 
FROM debian:jessie

EXPOSE 80

MAINTAINER Brennen Smith <brennen@wildwingstudios.com>

# Get Deps
RUN apt-get update && apt-get -y install \
    curl  \
    nginx-light \
    php5-fpm \
    php5-mysql \
    php5-gd

# Configure NGINX
RUN rm -rf /var/www/html/ /etc/nginx/sites-enabled/default
COPY lib/nginx/wordpress /etc/nginx/sites-enabled/
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Configure PHP5-FPM
COPY lib/php/www.conf /etc/php5/fpm/pool.d/www.conf


# Get Wordpress Core
ENV WPVER 4.2.2

RUN mkdir -p /var/www \
    && curl https://wordpress.org/wordpress-${WPVER}.tar.gz | tar -xz --exclude="wp-content" -C /var/www/ \
    && chown -R www-data:www-data /var/www/wordpress

# Cleanup 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD lib/start.sh /

# GO GO GO
CMD ["sh", "/start.sh"]
