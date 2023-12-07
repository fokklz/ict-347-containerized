# ASP.NET Web API

This project contains a simple ASP.NET Web API using Docker Compose.

General information about this project can be found in the [README.md](../README.md) one directory up.

## Configuration

### Services

These are the services that are used in this project:

| Service    | Image                          | Version     | Link                                                          |
|------------|--------------------------------|-------------|---------------------------------------------------------------|
| mssql      | mcr.microsoft.com/mssql/server | 2019-latest | [Docker Hub](https://hub.docker.com/r/fokklz/skiservice-api)  |
| skiservice | fokklz/skiservice-api          | latest      | [Docker Hub](https://hub.docker.com/_/microsoft-mssql-server) |

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
