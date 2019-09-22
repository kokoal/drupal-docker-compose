ARG drupal_version

FROM drupal:$drupal_version-fpm

# Install git
RUN apt-get update \
    && apt-get install -y git

# Install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer