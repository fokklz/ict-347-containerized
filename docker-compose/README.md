# Docker Compose (feat. Docker)

This directory contains some example kubernetes configurations. The configurations are meant to be used with [Docker Compose](https://docs.docker.com/compose/). 

Compose is a tool for defining and running multi-container Docker applications. The configurations include scripts to simplify the process of backup & restore. 

The projects use Docker Compose version 3.8 for yaml configurations.

## Contents<!-- omit in toc -->

- [Docker Compose (feat. Docker)](#docker-compose-feat-docker)
  - [Prerequisites](#prerequisites)
  - [Access](#access)
  - [Usage](#usage)
    - [Deploying](#deploying)
    - [Stopping](#stopping)
  - [Backup \& Restore](#backup--restore)
    - [Backup](#backup)
    - [Restore](#restore)


## Prerequisites

- [Docker Compose](https://docs.docker.com/compose/install/)

## Access

When deployed you can access the services by using they're port combined with any localhost address. Which service is exposed on which port can be found in the `README.md` file of each project. 

## Usage

Enter the directory of the project you want to work with. Each of the **commands below should be run from the project directory.**

### Deploying

To deploy a project, open a terminal in the project directory and run the following command:

```bash
docker compose up -d
```

### Stopping

To stop a project, open a terminal in the project directory and run the following command:

```bash
docker compose down
```

## Backup & Restore

### Backup

To create a backup, open a terminal in the project directory and run the following command:

```sh
# Unix
bash .\scripts\backup.sh
# Windows
powerhell .\scripts\backup.ps1
```

This command will create a new Compressed backup inside the `backup` directory.

### Restore

Place the Compressed backup you would like to restore into the `backup` directory and open a terminal in the project directory to run the following command:

```sh
# Unix
bash .\scripts\restore.sh name.zip
# Windows
powerhell .\scripts\restore.ps1 name.zip
```

The Script will decompress the Backup and overwrite the current environment in the container.