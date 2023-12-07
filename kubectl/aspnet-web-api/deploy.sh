#!/bin/bash

kubectl apply -f ./manifests/mssql-manifest.yml
kubectl apply -f ./manifests/aspnet-api-manifest.yml

echo "Successfully deployed!"