# WordPress Dockerized

## Overview

This Docker Compose project sets up a WordPress site with MariaDB as the database and phpMyAdmin for database management. It uses Docker Compose version 3.8.

## Contents<!-- omit from toc -->

- [WordPress Dockerized](#wordpress-dockerized)
  - [Overview](#overview)
  - [Services](#services)
  - [Configuration Details](#configuration-details)
    - [Environment Variables](#environment-variables)
    - [Ports](#ports)
    - [Volumes](#volumes)
    - [Dependency](#dependency)
  - [Starting the Project](#starting-the-project)
  - [Stopping the Project](#stopping-the-project)
  - [Backup \& Restore Instructions](#backup--restore-instructions)
    - [Create Backup](#create-backup)
    - [Restore Backup](#restore-backup)
    - [Notes](#notes)



## Services
The `docker-compose.yml` file defines three services:

| Service    | Image      | Version | Link                                              |
|------------|------------|---------|---------------------------------------------------|
| wordpress  | wordpress  | latest  | [Docker Hub](https://hub.docker.com/_/wordpress)  |
| mariadb    | mariadb    | latest  | [Docker Hub](https://hub.docker.com/_/mariadb)    |
| phpmyadmin | phpmyadmin | latest  | [Docker Hub](https://hub.docker.com/_/phpmyadmin) |

## Configuration Details

### Environment Variables

The project uses an `.env` file for environment variables. These variables are used to configure the services in `docker-compose.yml`.

| Variable                | Description                              |
|-------------------------|------------------------------------------|
| `MARIADB_ROOT_PASSWORD` | Root password for MariaDB                |
| `MARIADB_DATABASE`      | Database name for WordPress              |
| `MARIADB_USER`          | Username for the WordPress database      |
| `MARIADB_PASSWORD`      | Password for the WordPress database user |

### Ports
- WordPress is accessible at [http://localhost:10000](http://localhost:10000).
- phpMyAdmin is accessible at [http://localhost:10001](http://localhost:10001).

### Volumes
Persistent data volumes are used for both WordPress and MariaDB:

- `wordpress_data` for WordPress files.
- `mariadb_data` for MariaDB database files.

### Dependency
- `phpMyAdmin` and `WordPress` depend on `mariadb`.

## Starting the Project
To start the project, run the following command in the directory containing `docker-compose.yml`:

```
docker-compose up -d
```

This will start all the services in detached mode.

## Stopping the Project
To stop the project, run:

```
docker-compose down
```

## Backup & Restore Instructions

### Create Backup

```sh
# Unix
bash .\scripts\backup.sh
# Windows
powerhell .\scripts\backup.ps1
```

This command will create a new Compressed backup inside the `backup` directory.

### Restore Backup

Place the Compressed backup you would like to restore into the `backup` directory

```sh
# Unix
bash .\scripts\restore.sh name.zip
# Windows
powerhell .\scripts\restore.ps1 name.zip
```

The Script will decompress the Backup and Restore it on the current environment

### Notes

- The `.env` file must be properly configured with your environment variables.
- Execute the backup and restore commands from the directory containing the `docker-compose.yml`.