docker volume create postgres17-data

docker run -d \
  --name postgres17 \
  -e POSTGRES_HOST_AUTH_METHOD=trust \
  -p "127.0.0.1:5432:5432" \
  -v postgres17-data:/var/lib/postgresql/data \
  --restart unless-stopped \
  postgres:17

docker volume create redis-data

docker run -d \
  --name redis \
  -p "127.0.0.1:6379:6379" \
  -v redis-data:/data \
  --restart unless-stopped \
  redis:latest
