# 실행 방법

```
sudo apt update
sudo snap install docker  #docker compose까지 다운됨
```

### .env

- mysql database설정과, go server에서 접속하기 위한 설정입니다.

```env
JWT_SECRET=토큰비밀번호 #서비스 전 수정 필요

DB_HOST=mariadb
DB_USER=root
DB_PASS=비밀번호 #서비스 전 수정 필요
DB_NAME=vacation
DB_PORT=3307 # 이 포트는 실행 환경에서 열려있어야 합니다.
```

서비스 하려면 토큰 비밀번호와 비밀번호를 바꿔주세요

# 개발시

## docker compose 시

`> docker compose -f docker-compose.yml up --build -d`
--build를 하지 않으면, client image가 재시작되지

## docker 없이 webhook 개발 시

`> . ./webhook/.venv/bin/activate` 로
env 실행
`>pip install -r requirements.txt` 를 통해 의존성 다운로드

```

```
