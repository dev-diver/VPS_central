#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "sudo로 실행해주세요"
  exit 1
fi

echo "스크립트 시작"
PROJECT_DIR=$(dirname $(realpath $0))

cd $PROJECT_DIR

echo "git pull"
git pull origin main

echo "docker compose pull!"
docker-compose pull

exho "docker compose up"
docker-compose up -d
