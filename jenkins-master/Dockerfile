FROM jenkins:latest

MAINTAINER verbruggenalex <verbruggenalex@gmail.com>

# Switch to root user.
USER root

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C; \
    echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" >> /etc/apt/sources.list; \
    echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu trusty main" >> /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
apt-get -qq install php7.0-cli php7.0-mbstring php7.0-xml curl git sudo unzip libltdl-dev

# Install jenkins plugins.
RUN mkdir -p /usr/share/jenkins/ref
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY install-plugins.sh /usr/local/bin/install-plugins.sh
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Install altlassian theme.
RUN mkdir -p /usr/share/jenkins/ref/userContent
COPY atlassian /usr/share/jenkins/ref/userContent
RUN chown -R jenkins:jenkins /usr/share/jenkins/ref/userContent

# Set theme css and js settings.
ADD atlassian/org.codefirst.SimpleThemeDecorator.xml /usr/share/jenkins/ref/

# Install Docker client
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.12.6
ENV DOCKER_SHA256 cadc6025c841e034506703a06cf54204e51d0cadfae4bae62628ac648d82efdd

RUN set -x \
	&& curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v

# Give jenkins access to docker
RUN groupadd -g 117 docker
RUN gpasswd -a jenkins docker

# Give jenkins access to apache
RUN groupadd -g 48 apache
RUN useradd  -u 48 -g 48 apache
RUN gpasswd -a apache jenkins

# Add docker composer script.
ADD composer /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Provide a persistent composer cache location.
RUN mkdir -p /var/cache/composer

# Make jenkins the full owner.
RUN chown -R 1000:1000 var/jenkins_home

USER jenkins
