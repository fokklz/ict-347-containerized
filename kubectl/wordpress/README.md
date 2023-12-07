# Wordpress

This directory contains a kubernetes configuration for a wordpress instance.

General information about this project can be found in the [README.md](../README.md) one directory up.

## Configuration

**Namespace:** `wordpress-containerized`<br>
**Persistent Volume Claims:** `wordpress-pvc`, `mariadb-pvc`<br>
### Secrets 
- `mariadb-secret/mariadb-password`
- `mariadb-secret/mariadb-root-password`

### Services

| Name       | Type      | Port  | Exposed | Description             |
|------------|-----------|-------|---------|-------------------------|
| wordpress  | NodePort  | 30001 | ✔       | The wordpress instance  |
| mysql      | ClusterIP | 3306  | -       | The mysql database      |
| phpmyadmin | NodePort  | 30002 | ✔       | The phpmyadmin instance |