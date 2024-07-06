#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
  echo "sudo로 실행해주세요"
  exit 1
fi

echo "도커 컴포즈 시작"
PROJECT_DIR=$(dirname $(realpath $0))

cd $PROJECT_DIR

echo "git pull"
git pull origin main

echo "docker compose pull"
docker-compose pull || { echo "docker-compose pull 실패"; exit 1; }

# # 기존 볼륨 제거
# PROJECT_NAME=$(basename "$PROJECT_DIR" | tr '[:upper:]' '[:lower:]')
# VOLUME_NAME="${PROJECT_NAME}_front_web"

# echo "기존 front_web 볼륨 제거: $VOLUME_NAME"
# docker volume rm  -f "$VOLUME_NAME"

echo "docker compose up"
docker-compose up -d  || { echo "docker-compose up 실패"; exit 1; }

echo "도커 컴포즈 완료"