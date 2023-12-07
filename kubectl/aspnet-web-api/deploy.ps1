kubectl apply -f .\manifests\mssql-manifest.yml
kubectl apply -f .\manifests\aspnet-api-manifest.yml

Write-Host "Successfully deployed!"