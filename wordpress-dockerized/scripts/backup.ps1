# Load environment variables from .env file
Get-Content .env | ForEach-Object {
    $line = $_.Split('=')
    [System.Environment]::SetEnvironmentVariable($line[0], $line[1], [System.EnvironmentVariableTarget]::Process)
}

# Define backup directory and file name
$backupDirBase = "backup"
$dateString = Get-Date -Format "yyyyMMdd_HHmmss"
$backupDir = "${backupDirBase}\${dateString}"

# Create the backup directory
New-Item -Path "${backupDir}" -ItemType "directory" -ErrorAction SilentlyContinue

# Perform the backups
docker-compose exec wordpress tar czvf /var/backups/backup.tar.gz /var/www/html
docker compose exec mariadb sh -c "mariadb-dump -uroot -p`"${env:MARIADB_ROOT_PASSWORD}`" --all-databases > /backup/mariadb_dump.sql"
docker compose exec mariadb sh -c "mariadb-dump -uroot -p`"${env:MARIADB_ROOT_PASSWORD}`" --databases ${env:MARIADB_DATABASE} > /backup/mariadb_dump_wordpress.sql"

# Copy to the host
docker-compose cp wordpress:/var/backups/backup.tar.gz "${backupDir}\wordpress.tar.gz"
docker compose cp mariadb:/backup/mariadb_dump_wordpress.sql "${backupDir}\mariadb-wordpress-database.sql"
docker compose cp mariadb:/backup/mariadb_dump.sql "${backupDir}\mariadb-full-database.sql"

# Compress the backup
Compress-Archive -Path "${backupDir}\*" -DestinationPath "${backupDirBase}\${dateString}.zip"

# Remove the uncompressed backup
Remove-Item -Path "${backupDir}" -Recurse