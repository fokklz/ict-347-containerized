kubectl apply -f .\manifests\mariadb-manifest.yml
kubectl apply -f .\manifests\phpmyadmin-manifest.yml
kubectl apply -f .\manifests\wordpress-manifest.yml

Write-Host "Successfully deployed!"