#!/bin/bash

source ./.env

SERVICE_NAME=service-strapi
REPOSITORY=$REGION-docker.pkg.dev/$PRODUCTION_ID/cloud-run-source-deploy/$SERVICE_NAME:latest

# 要 gcloud auth configure-docker $REGION-docker.pkg.dev の実行
docker build -f packages/$SERVICE_NAME/Dockerfile -t $REPOSITORY .
docker push $REPOSITORY
gcloud run deploy $SERVICE_NAME --image $REPOSITORY --region asia-northeast1 --platform managed --allow-unauthenticated
docker image rm $REPOSITORY

