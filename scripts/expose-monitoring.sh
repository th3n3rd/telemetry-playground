#!/bin/bash

echo "Prometheus URL: http://localhost:9090/"
kubectl port-forward svc/monitoring-kube-prometheus-prometheus 9090:9090

