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

# 클라이언트, 서버 중지 및 제거
docker-compose stop client server

# 기존 볼륨 데이터 제거
VOLUME_NAME="${PROJECT_NAME}_front_web"
VOLUME_PATH=$(docker volume inspect --format '{{ .Mountpoint }}' $VOLUME_NAME)
sudo rm -rf "$VOLUME_PATH"/*

echo "docker compose pull!"
docker-compose pull || { echo "docker-compose pull 실패"; exit 1; }

echo "docker compose up"
docker-compose up -d client server
docker-compose up -d client server || { echo "docker-compose up 실패"; exit 1; }

echo "script 완료"