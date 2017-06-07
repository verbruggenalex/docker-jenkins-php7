# FPFIS Jenkins Docker project
<img align="left" width="25%" src="http://www.tothenew.com/blog/wp-content/uploads/2015/10/627x302xdocker-jenkins.png.pagespeed.ic.rdLVquN8qf.png">

This project serves as the FPFIS Continuous Integration platform to provide Quality Assurance for the FPFIS project. It is especially constructed for [Subsite Starter Kit >=3.0](https://github.com/ec-europa/ssk) support. This project has been opensourced as the other NextEuropa projects. We encourage our users to install and contribute to the project.

## Installation requirements:
- docker-ce
- docker-compose
- make

## Components:
- [official jenkins docker image](https://github.com/jenkinsci/docker)
- php7.0 & composer
- nginx reverse proxy
- additional plugins
- atlassian theme
- docker in docker support
