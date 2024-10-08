#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo "sudo로 실행해주세요"
  exit 1
fi

echo "프로젝트 최신화 시작"
PROJECT_DIR=$(dirname $(realpath $0))

cd $PROJECT_DIR

echo "git pull"
git pull origin main

echo "docker compose pull"
docker-compose pull || { echo "docker-compose pull 실패"; exit 1; }

echo "docker client stop"
docker-compose stop client || { echo "docker-compose stop 실패"; exit 1; }

echo "docker client rm"
docker-compose rm -f client || { echo "docker-compose rm 실패"; exit 1; }

echo "docker container prune"
docker container prune -f || { echo "docker container prune 실패"; exit 1; }

echo "docker compose up"
docker-compose up -d  || { echo "docker-compose up 실패"; exit 1; }

echo "도커 컴포즈 완료"