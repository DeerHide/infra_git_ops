#!/usr/bin/env bash

SECRET_NAME=velmios-env-configuration

TMP_FILE=$(mktemp)

MINIO_ROOT_USER=${MINIO_ROOT_USER:-velmios-minio-admin}
MINIO_ROOT_PASSWORD=$(openssl rand -hex 20)

cat <<EOF >> $TMP_FILE
export MINIO_ROOT_USER=$MINIO_ROOT_USER
export MINIO_ROOT_PASSWORD=$MINIO_ROOT_PASSWORD
EOF

kubectl create -n minio secret generic $SECRET_NAME \
  --from-file=config.env=$TMP_FILE \
  --dry-run=client -o yaml | kubectl apply -f -
