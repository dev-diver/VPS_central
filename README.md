# 실행 방법

````
sudo apt update
sudo snap install docker  #docker compose까지 다운됨

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




````
