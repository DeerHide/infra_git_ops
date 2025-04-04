#!/usr/bin/env bash

SECRET_NAME=grafana-admin

GRAFANA_ADMIN_USER=${MINIO_ROOT_USER:-velmios-grafana-admin}
GRAFANA_ADMIN_PASSWORD=$(openssl rand -hex 20)

kubectl create -n monitoring-grafana secret generic $SECRET_NAME \
  --from-literal=admin-user=$GRAFANA_ADMIN_USER \
  --from-literal=admin-password=$GRAFANA_ADMIN_PASSWORD \
  --dry-run=client -o yaml | kubectl apply -f -
