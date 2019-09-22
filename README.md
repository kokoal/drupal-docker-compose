# Drupal docker-compose
A docker-compose and tools to fast launch a Drupal project.

## Requirements
- Docker is installed and running
- Traefik is installed and running
- Docker compose is installed

## Set up environment variables
- Before doing annything you need to change environment variables as you wish

Variable | Definition
------------ | -------------
PROJECT_NAME | The project name will be used to name containers and set up a domain name with traefik. (Domain name example : www.test.loc with PROJECT_NAME=test).
DRUPAL_VERSION | Wanted Drupal version (Examples : 8, 8.7, 8.7.7).
NGINX_VERSION | Wanted NGINX version if you are using nginx.
DATABASE_VERSION | The database version number.
DATABASE_NAME | The future first Drupal databse name.
DATABASE_ROOT_PASSWORD | The root database password. 

## Use the pre-launching script


## Launch your Drupal app

## Drupal installation
### Configure your database connection

## Tested with
- Docker 18.06.0-ce
- Traefk in a different container
