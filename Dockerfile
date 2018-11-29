FROM php:7-apache
MAINTAINER Sean Zhang <zxf2342@qq.com>

ARG LAM_VERSION=6.5

RUN apt-get update \
 && apt-get install -y wget libzip-dev libghc-ldap-dev \
 && docker-php-ext-install gettext zip ldap \
 && wget http://prdownloads.sourceforge.net/lam/ldap-account-manager-${LAM_VERSION}.tar.bz2?download -O /tmp/ldap-account-manager.tar.bz2 \
 && tar xf /tmp/ldap-account-manager.tar.bz2 -C /var/www/ \
 && rm -rf /var/www/html \
 && mv /var/www/ldap-account-manager-${LAM_VERSION} /var/www/html \
 && chown www-data:www-data /var/www/html/config  \
 && chown www-data:www-data /var/www/html/sess  \
 && chown www-data:www-data /var/www/html/tmp \
 && ln -sf /config/config.cfg /var/www/html/config/config.cfg \
 && ln -sf /config/lam.conf /var/www/html/config/lam.conf \
 && ln -sf /dev/stdout /var/log/apache2/access.log \
 && ln -sf /dev/stderr /var/log/apache2/error.log \
 && apt-get autoremove -y && apt-get clean all \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /config
