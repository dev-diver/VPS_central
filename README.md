# 설정 파일

````
sudo snap install docker  #docker compose까지 다운됨


```plaintext
VPS_CENTRAL/
├── config/
│   ├── .env        <------
├── database/
│   ├── conf.d/
│   │   └── my.cnf
│   ├── initd.d/
│   │   └── init.sql
│   ├── .env        <------
├── docker-compose.yml
└── README.md
````

- 위 두개 파일만 설정하면 됩니다.

### /config/.env

- jwt를 암호화하기 위한 secret key를 설정합니다.

```env
JWT_SECRET=토큰비밀번호
```

### /database/.env

- mysql database설정과, go server에서 접속하기 위한 설정입니다.

```env
MYSQL_ROOT_PASSWORD=루트비밀번호
MYSQL_DATABASE=데이터베이스명
MYSQL_USER=유저명
MYSQL_PASSWORD=유저비밀번호

DATABASE_HOST=데이터베이스호스트 (아래 참고)
DATABASE_PORT=3306   (포트 번호 바꾸시고 싶으면 바꾸세요)
DATABASE_USER=유저명  (위와 같아야 합니다.)
DATABASE_PASSWORD=유저비밀번호 (위와 같아야 합니다.)
DATABASE_NAME=데이터베이스명 (위와 같아야 합니다.)
```

데이터베이스 호스트는 docker-compose 배포시에는 mariadb, 개발시에는 127.0.0.1 로 잡으시면 됩니다.
