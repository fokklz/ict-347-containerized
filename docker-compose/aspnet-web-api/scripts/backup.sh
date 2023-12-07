#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Extract database name from connection string
databaseName=$(echo $CONNECTION_STRING | cut -d ';' -f 2 | sed 's/Database=//')

# Define backup directory and file name
backupDirBase="backup"
dateString=$(date +"%Y%m%d_%H%M%S")
backupDir="${backupDirBase}/${dateString}"

# Create the backup directory
mkdir -p "${backupDir}"

echo "Backing up database '$databaseName' to '$backupDir'"

# Perform MSSQL database backup
backupFileName="mssql_backup.bak"
docker compose exec mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "${SA_PASSWORD}" -Q "BACKUP DATABASE [$databaseName] TO DISK = N'/var/opt/mssql/data/$backupFileName' WITH NOFORMAT, MEDIANAME = 'SQLServerBackups', NAME = 'Full Backup of $databaseName';"
docker compose cp mssql:/var/opt/mssql/data/$backupFileName "${backupDir}/$backupFileName"

# [Optional] Add commands to back up data from 'skiservice' if needed

# Compress the backup
zip -r "${backupDirBase}/${dateString}.zip" "${backupDir}"

# Remove the uncompressed backup
rm -rf "${backupDir}"
