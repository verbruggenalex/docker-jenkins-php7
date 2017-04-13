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

# Make composer service executable by other containers.
ADD composer /usr/local/bin/composer
RUN chmod a+x /usr/local/bin/composer && \
    chown jenkins:jenkins /usr/local/bin/composer

RUN chown -R jenkins:jenkins /var/jenkins_home

#New to docker 1.12
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
      CMD curl -f http://localhost:8080 || exit 1

USER jenkins
