# Load environment variables from .env file
Get-Content .env | ForEach-Object {
    $key, $value = $_ -split '=', 2
    [System.Environment]::SetEnvironmentVariable($key, $value, [System.EnvironmentVariableTarget]::Process)
}

$connectionString = [System.Environment]::GetEnvironmentVariable("CONNECTION_STRING")
$databaseName = ($connectionString -split ";")[1] -replace "Database=", ""

# Define backup directory and file name
$backupDirBase = "backup"
$dateString = Get-Date -Format "yyyyMMdd_HHmmss"
$backupDir = "${backupDirBase}\${dateString}"

# Create the backup directory
New-Item -Path "${backupDir}" -ItemType "directory" -ErrorAction SilentlyContinue

Write-Host "Backing up database '$databaseName' to '$backupDir'"

# Perform MSSQL database backup
$backupFileName = "mssql_backup.bak"
docker compose exec mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "${env:SA_PASSWORD}" -Q "BACKUP DATABASE [$databaseName] TO DISK = N'/var/opt/mssql/data/$backupFileName' WITH NOFORMAT, MEDIANAME = 'SQLServerBackups', NAME = 'Full Backup of $databaseName';"
docker compose cp mssql:/var/opt/mssql/data/$backupFileName "${backupDir}\$backupFileName"

# [Optional] Add commands to back up data from 'skiservice' if needed

# Compress the backup
Compress-Archive -Path "${backupDir}\*" -DestinationPath "${backupDirBase}\${dateString}.zip"

# Remove the uncompressed backup
Remove-Item -Path "${backupDir}" -Recurse
