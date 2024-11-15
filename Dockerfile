FROM python:3-slim-bookworm

# 필수 패키지 및 Docker CLI 설치
RUN apt-get update && apt-get install -y \
  ca-certificates \
  curl \
  gnupg &&\
  install -m 0755 -d /etc/apt/keyrings && \
  curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
  chmod a+r /etc/apt/keyrings/docker.asc && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  apt-get update && \
  apt-get install -y docker-ce docker-ce-cli && \
  rm -rf /var/lib/apt/lists/*

RUN groupadd -f docker && usermod -aG docker root

# Flask 설치

COPY /webhook /vps_central/webhook

WORKDIR /vps_central/webhook
RUN pip install -r requirements.txt

COPY /docker-compose.yml /vps_central/docker-compose.yml
COPY /docker-compose.override.yml /vps_central/docker-compose.override.yml
COPY /.env /vps_central

EXPOSE 5000

WORKDIR /vps_central

CMD ["python", "-u", "/vps_central/webhook/server.py"]