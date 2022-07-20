#!/bin/bash

echo "App URL: http://localhost:8080/"
kubectl port-forward svc/telemetry 8080:80

