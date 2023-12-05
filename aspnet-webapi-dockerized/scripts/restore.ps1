# Load environment variables from .env file
Get-Content .env | ForEach-Object {
    $key, $value = $_ -split '=', 2
    [System.Environment]::SetEnvironmentVariable($key, $value, [System.EnvironmentVariableTarget]::Process)
}

# Extract database name from connection string
$connectionString = [System.Environment]::GetEnvironmentVariable("CONNECTION_STRING")
$databaseName = ($connectionString -split ";")[1] -replace "Database=", ""

# Ensure a file name is provided as command line argument
if ($args.Length -eq 0) {
    Write-Host "Please provide a file name of a compressed file as command line argument"
    exit
}
$fileName = $args[0]
$backupDirBase = "backup"
$sourceFile = "${backupDirBase}\${fileName}"
$backupDir = "$sourceFile".Replace(".zip", "")

# Ensure the file exists
if (-not (Test-Path $sourceFile)) {
    Write-Host "File $sourceFile does not exist"
    exit
}

# Ensure the file is a zip file
if (-not ($sourceFile -like "*.zip")) {
    Write-Host "File $sourceFile is not a zip file"
    exit
}

# Uncompress the backup
Expand-Archive -Path "${sourceFile}" -DestinationPath "${backupDir}"

# Restore MSSQL database
$backupFileName = "mssql_backup.bak"
docker cp "${backupDir}\${backupFileName}" mssql:/var/opt/mssql/data/$backupFileName
docker compose exec mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "${env:SA_PASSWORD}" -Q "RESTORE DATABASE [$databaseName] FROM DISK = N'/var/opt/mssql/data/$backupFileName' WITH FILE = 1, NOUNLOAD, REPLACE, STATS = 10"

