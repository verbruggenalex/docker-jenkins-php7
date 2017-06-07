# FPFIS Jenkins Docker project

This project serves as the FPFIS Continuous Integration to provide NextEuropa subsites with Quality Assurance.

It consists of a Docker image based on the [official jenkins docker image](https://github.com/jenkinsci/docker) extended with:
- php7.0 & composer
- nginx reverse proxy
- additional plugins
- atlassian theme
- docker in docker support

Requirements for [Subsite Starter Kit](https://github.com/ec-europa/ssk) support:
- run composer pre-docker (ssk installation)
- run phing pre-docker (spawn environment)
- run docker in docker (simulate EC server environment)
