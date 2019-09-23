ARG DRUPAL_VERSION

FROM drupal:${DRUPAL_VERSION}-fpm

# Install git
RUN apt-get update \
    && apt-get install -y git

# Install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer