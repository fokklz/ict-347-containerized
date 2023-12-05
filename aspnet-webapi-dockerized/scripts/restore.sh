#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Extract database name from connection string
databaseName=$(echo $CONNECTION_STRING | cut -d ';' -f 2 | sed 's/Database=//')

# Ensure a file name is provided as command line argument
if [ $# -eq 0 ]; then
    echo "Please provide a file name of a compressed file as command line argument"
    exit 1
fi
fileName=$1
backupDirBase="backup"
sourceFile="${backupDirBase}/${fileName}"
backupDir="${sourceFile%.zip}"

# Ensure the file exists
if [ ! -f "$sourceFile" ]; then
    echo "File $sourceFile does not exist"
    exit 1
fi

# Ensure the file is a zip file
if [[ $sourceFile != *.zip ]]; then
    echo "File $sourceFile is not a zip file"
    exit 1
fi

# Uncompress the backup
unzip -q "$sourceFile" -d "$backupDir"

# Restore MSSQL database
backupFileName="mssql_backup.bak"
docker cp "${backupDir}/${backupFileName}" mssql:/var/opt/mssql/data/$backupFileName
docker compose exec mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "RESTORE DATABASE [$databaseName] FROM DISK = N'/var/opt/mssql/data/$backupFileName' WITH FILE = 1, NOUNLOAD, REPLACE, STATS = 10"
