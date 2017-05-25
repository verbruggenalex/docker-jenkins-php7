FROM jenkins:latest

MAINTAINER verbruggenalex <verbruggenalex@gmail.com>

# Switch to root user.
USER root

# Install jenkins plugins.
RUN mkdir -p /usr/share/jenkins/ref
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/ref/plugins.txt | tr '\n' ' ')

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

# Provide a persistent composer cache location.
RUN mkdir -p /var/cache/composer

# Make jenkins the full owner.
RUN chown -R jenkins:jenkins /var/jenkins_home

USER jenkins
