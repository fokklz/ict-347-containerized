#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Define backup directory and file name
backupDirBase="backup"
dateString=$(date +"%Y%m%d_%H%M%S")
backupDir="${backupDirBase}/${dateString}"

# Create the backup directory
mkdir -p "${backupDir}"

# Perform the backups
docker-compose exec wordpress tar czvf /var/backups/backup.tar.gz /var/www/html
docker-compose exec mariadb sh -c "mysqldump -uroot -p\"${MARIADB_ROOT_PASSWORD}\" --all-databases > /backup/mariadb_dump.sql"
docker-compose exec mariadb sh -c "mysqldump -uroot -p\"${MARIADB_ROOT_PASSWORD}\" --databases ${MARIADB_DATABASE} > /backup/mariadb_dump_wordpress.sql"

# Copy to the host
docker-compose cp wordpress:/var/backups/backup.tar.gz "${backupDir}/wordpress.tar.gz"
docker-compose cp mariadb:/backup/mariadb_dump_wordpress.sql "${backupDir}/mariadb-wordpress-database.sql"
docker-compose cp mariadb:/backup/mariadb_dump.sql "${backupDir}/mariadb-full-database.sql"

# Compress the backup
tar -czvf "${backupDirBase}/${dateString}.tar.gz" -C "${backupDirBase}" "${dateString}"

# Remove the uncompressed backup
rm -rf "${backupDir}"
