#!/bin/bash

# sudo 권한 체크
if [ "$EUID" -ne 0 ]; then
  echo "sudo로 실행해주세요"
  exit 1
fi

echo "스크립트 시작"
PROJECT_DIR=$(dirname $(realpath $0))

echo "Flask 애플리케이션 실행"
nohup python3 "$PROJECT_DIR/app/webhook-server.py" > "$PROJECT_DIR/app/webhook-server.log" 2>&1 &

echo "Docker Compose 업데이트"
sh "$PROJECT_DIR/docker-compose-update.sh"

echo "Flask 애플리케이션과 Docker Compose가 실행되었습니다."