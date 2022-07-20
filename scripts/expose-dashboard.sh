#!/bin/bash

echo "User: admin"
echo "Password: $(kubectl get secret dashboard-grafana-admin --namespace default -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"

echo "Grafana URL: http://localhost:8080"
kubectl port-forward svc/dashboard-grafana 8080:3000
