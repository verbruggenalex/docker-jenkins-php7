FROM jenkins:latest

MAINTAINER verbruggenalex <verbruggenalex@gmail.com>

USER root

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C; \
    echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" >> /etc/apt/sources.list; \
    echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" >> /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get -qq install php7.0-cli php7.0-mbstring curl git sudo unzip

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/ref/plugins.txt | tr '\n' ' ')

RUN sed -i 's|disable_functions.*=|;disable_functions=|' /etc/php/7.0/cli/php.ini; \
    sed -i 's/^error_reporting = .*/error_reporting = E_ALL \& ~E_STRICT/' /etc/php/7.0/cli/php.ini; \
    sed -i 's/^display_errors = .*/display_errors = On/' /etc/php/7.0/cli/php.ini; \
    echo "xdebug.max_nesting_level = 500" >> /etc/php/7.0/mods-available/xdebug.ini

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN mkdir -p /usr/share/jenkins/ref/composer/bin && chown -R jenkins:jenkins /usr/share/jenkins/ref/composer; \
    sudo -H -u jenkins bash -c ' \
        curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/share/jenkins/ref/composer/bin --filename=composer;'; \
    ln -s /usr/share/jenkins/ref/composer/bin/composer /usr/local/bin/; \
    sudo -H -u jenkins bash -c ' \
        export COMPOSER_BIN_DIR=/usr/share/jenkins/ref/composer/bin; \
        export COMPOSER_HOME=/usr/share/jenkins/ref/composer;'
RUN sudo sed -i '$ d' /etc/sudoers

USER jenkins

