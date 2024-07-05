#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "sudo로 실행해주세요"
  exit 1
fi

PROJECT_DIR=$(dirname $(realpath $0))

cd $PROJECT_DIR

git pull origin main

docker-compose pull

docker-compose up -d
