# Load environment variables from .env file
Get-Content .env | ForEach-Object {
    $line = $_.Split('=')
    [System.Environment]::SetEnvironmentVariable($line[0], $line[1], [System.EnvironmentVariableTarget]::Process)
}

# Ensure a file name is provided as command line argument
if ($args.Length -eq 0) {
    Write-Host "Please provide a file name of a compressed file as command line argument"
    exit
}
$fileName = $args[0]
$backupDirBase = "backup"
$backupDir = "${backupDirBase}\${fileName}".Replace(".zip", "")

# Ensure the file exists
if (-not (Test-Path $fileName)) {
    Write-Host "File $fileName does not exist"
    exit
}

# Ensure the file is a zip file
if (-not ($fileName -like "*.zip")) {
    Write-Host "File $fileName is not a zip file"
    exit
}


# Uncompress the backup
Expand-Archive -Path "${backupDirBase}\${fileName}" -DestinationPath "${backupDir}"

# Copy from the host (overwrite)
docker-compose cp "${backupDir}\wordpress.tar.gz" wordpress:/var/backups/backup.tar.gz
docker-compose cp "${backupDir}\mariadb-wordpress-database.sql" mariadb:/backup/mariadb_dump_wordpress.sql

# Restore the backups
docker-compose exec wordpress rm -rf /var/www/html/*
docker-compose exec wordpress tar xzvf /var/backups/backup.tar.gz -C /var/www/html
docker-compose exec mariadb sh -c "mariadb -uroot -p`"${env:MARIADB_ROOT_PASSWORD}`" < /backup/mariadb_dump_wordpress.sql"