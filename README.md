# 설정 파일

````
sudo apt update
sudo snap install docker  #docker compose까지 다운됨
sudo apt install python3-pip
sudo pip3 install flask

```plaintext
VPS_CENTRAL/ 
├── database/
│   ├── conf.d/
│   │   └── my.cnf
│   └── initd.d/
│        └── init.sql
├── docker-compose.yml
├── .env        <------
└── README.md
````
- .env 파일만 설정하면 됩니다.

### .env
- mysql database설정과, go server에서 접속하기 위한 설정입니다.

```env
JWT_SECRET=토큰비밀번호 #서비스 전 수정 필요

DB_HOST=localhost
DB_USER=root
DB_PASS=비밀번호 #서비스 전 수정 필요
DB_NAME=vacation
DB_PORT=3307 # 이 포트는 실행 환경에서 열려있어야 합니다.
```

데이터베이스 호스트는 docker-compose 배포시에는 mariadb, 개발시에는 127.0.0.1 로 잡으시면 됩니다.
