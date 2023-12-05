# ASP.NET Web API Dockerized

## Overview

This Docker Compose project sets up a ski service application with a Microsoft SQL Server (MSSQL) database. It uses Docker Compose version 3.8. The ski service application is a RESTful API for managing ski-related services.

## Contents<!-- omit from toc -->

- [ASP.NET Web API Dockerized](#aspnet-web-api-dockerized)
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

The `docker-compose.yml` file defines two services:

| Service    | Image                          | Version     | Link                                                          |
|------------|--------------------------------|-------------|---------------------------------------------------------------|
| mssql      | mcr.microsoft.com/mssql/server | 2019-latest | [Docker Hub](https://hub.docker.com/r/fokklz/skiservice-api)  |
| skiservice | fokklz/skiservice-api          | latest      | [Docker Hub](https://hub.docker.com/_/microsoft-mssql-server) |

## Configuration Details

### Environment Variables

The project uses an `.env` file for environment variables. These variables are used to configure the services in `docker-compose.yml`.

| Variable            | Description                           |
|---------------------|---------------------------------------|
| `SA_PASSWORD`       | The password for the SQL Server admin |
| `CONNECTION_STRING` | Connection string for the database.   |
| `ALLOWED_ORIGINS`   | Allowed origins for CORS policy.      |

### Ports

- SkiService is accessible at [http://localhost:10000](http://localhost:10000).
- SkiService-Swagger is accessible at [http://localhost:10000/swagger/index.html](http://localhost:10000/swagger/index.html).

### Volumes

- `mssql_data` for MSSQL Data
- `skiservice_logs` for Ski Service Logfiles

### Dependency

- The `skiservice` service depends on the `mssql` service.

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