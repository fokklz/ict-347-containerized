#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Ensure a file name is provided as command line argument
if [ "$#" -eq 0 ]; then
    echo "Please provide a file name of a compressed file as command line argument"
    exit 1
fi
fileName=$1

# Ensure the file exists
if [ ! -f "$fileName" ]; then
    echo "File $fileName does not exist"
    exit 1
fi

# Ensure the file is a zip file
if [[ $fileName != *.zip ]]; then
    echo "File $fileName is not a zip file"
    exit 1
fi

# Get file name from command line argument
backupDirBase="backup"
backupDir="${backupDirBase}/${fileName%.zip}"

# Uncompress the backup
mkdir -p "$backupDir"
unzip -o "$fileName" -d "$backupDir"

# Copy from the host (overwrite)
docker-compose cp "${backupDir}/wordpress.tar.gz" wordpress:/var/backups/backup.tar.gz
docker-compose cp "${backupDir}/mariadb-wordpress-database.sql" mariadb:/backup/mariadb_dump_wordpress.sql

# Restore the backups
docker-compose exec wordpress rm -rf /var/www/html/*
docker-compose exec wordpress tar xzvf /var/backups/backup.tar.gz -C /var/www/html
docker-compose exec mariadb sh -c "mysql -uroot -p\"$MARIADB_ROOT_PASSWORD\" < /backup/mariadb_dump_wordpress.sql"
