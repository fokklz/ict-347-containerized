# WordPress Dockerized

This project is a simple WordPress setup using Docker Compose.

General information about this project can be found in the [README.md](../README.md) one directory up.

## Configuration

### Services

These are the services that are used in this project:

| Name       | Image      | Version | Link                                              |
|------------|------------|---------|---------------------------------------------------|
| wordpress  | wordpress  | latest  | [Docker Hub](https://hub.docker.com/_/wordpress)  |
| mariadb    | mariadb    | latest  | [Docker Hub](https://hub.docker.com/_/mariadb)    |
| phpmyadmin | phpmyadmin | latest  | [Docker Hub](https://hub.docker.com/_/phpmyadmin) |

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

- `wordpress_data` for WordPress files.
- `mariadb_data` for MariaDB database files.

### Dependency

- `phpMyAdmin` and `WordPress` depend on `mariadb`.
