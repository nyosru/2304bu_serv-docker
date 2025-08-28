# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Production stage with Caddy
FROM caddy:2-alpine

# Копируем собранное приложение
COPY --from=builder /app/dist /usr/share/caddy

# Копируем конфиг Caddy (опционально)
COPY Caddyfile /etc/caddy/Caddyfile

EXPOSE 80