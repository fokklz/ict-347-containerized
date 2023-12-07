# ASP.NET Web API

This directory contains a kubernetes configuration for an ASP.NET Web API instance.

General information about this project can be found in the [README.md](../README.md) one directory up.

## Configuration

**Namespace:**
`aspnet-api-containerized`<br>
**Persistent Volume Claims:** 
`mssql-data`, `skiservice-logs-pvc`<br>

### Secrets

- `mssql-secret/sa-password`
- `skiservice-secret/connection-string`

### Services

| Name       | Type      | Port  | Exposed | Description             |
|------------|-----------|-------|---------|-------------------------|
| skiservice | NodePort  | 30003 | ✔       | The skiservice instance |
| mssql      | ClusterIP | 1433  | -       | The mssql database      |