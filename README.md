# FPFIS Jenkins Docker project

This project serves as the FPFIS Continuous Integration to provide NextEuropa subsites with Quality Assurance. It is especially constructed for [Subsite Starter Kit](https://github.com/ec-europa/ssk) support. And opensourced as the other NextEuropa projects we encourage our users to install and contribute to the project.

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
