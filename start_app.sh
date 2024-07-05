#!/bin/bash

# sudo 권한 체크
if [ "$EUID" -ne 0 ]; then
  echo "sudo로 실행해주세요"
  exit 1
fi

# 프로젝트 디렉토리 설정
PROJECT_DIR=$(dirname $(realpath $0))

VIRTUAL_ENV_DIR="$PROJECT_DIR/venv"
if [ ! -d "$VIRTUAL_ENV_DIR" ]; then
  python3 -m venv "$VIRTUAL_ENV_DIR"
fi
source "$VIRTUAL_ENV_DIR/bin/activate"

# 필요한 패키지 설치
pip install flask

# Flask 애플리케이션을 데몬으로 실행
nohup python3 "$PROJECT_DIR/app/webhook_server.py" > "$PROJECT_DIR/app/webhook_server.log" 2>&1 &

# Docker Compose 실행
sh "$PROJECT_DIR/docker-compose-up.sh"

echo "Flask 애플리케이션과 Docker Compose가 실행되었습니다."