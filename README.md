Disclaimer: Drupal shouldn't be running with nginx, to much to correct.

# Drupal docker-compose
A docker-compose and tools to fast launch a Drupal project.

## Requirements
- Docker is installed and running
- Traefik is installed and running
- You have a network named `proxy` and you have set traefik up in it
- Docker compose is installed

## Set up environment variables
- Before doing annything you need to change environment variables as you wish

Variable | Definition
------------ | -------------
PROJECT_NAME | The project name will be used to name containers and set up a domain name with traefik. (Domain name example : www.test.localhost with PROJECT_NAME=test).
DRUPAL_VERSION | Wanted Drupal version (Examples : 8, 8.7, 8.7.7).
SERVER_VERSION | Wanted Server version.
DATABASE_VERSION | The database version number.
DATABASE_NAME | The future first Drupal databse name.
DATABASE_ROOT_PASSWORD | The root database password. 

## Use the pre-launching script
- Run the pre-launcher to set up all files and folder necessary to Drupal development :
```bash ./install/pre-launching.sh```

## Launch your Drupal app

## Drupal installation (Follow the official  core/INSTALL.txt)
### Prepare Drupal install from recommandation
```
mkdir sites/default/files
chmod a+w sites/default
chmod a+w sites/default/files
cp sites/default/default.settings.php sites/default/settings.php
chmod a+w sites/default/settings.php
```
Then run website to start install.

### Configure your database connection

### Secure your app
- Change rights according to the Drupal install recommandations.

```
chmod go-w sites/default/settings.php
chmod go-w sites/default
```


## Tested with
- Docker 18.06.0-ce
- Traefk in a different container (version : 2.1.4)
