FROM ubuntu:xenial
MAINTAINER verbruggenalex@gmail.com

# Create the jenkins user

# Create the folders and volume mount points
RUN mkdir -p /var/lib/jenkins
RUN chown -R jenkins:jenkins /var/lib/jenkins
RUN useradd -d "/var/lib/jenkins" -u 1000 -m -s /bin/bash jenkins

VOLUME ["/var/lib/jenkins:/var/jenkins_home"]

USER jenkins
CMD ["echo", "Data container for Jenkins"]
