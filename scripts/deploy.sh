#!/bin/bash

kubectl delete all -l app=telemetry
kubectl apply -f manifests/deployment-manifest.yaml
