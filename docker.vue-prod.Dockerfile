# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Копируем package files
COPY package*.json ./

# Устанавливаем зависимости
RUN npm ci --only=production

# Копируем исходный код
COPY . .

# Собираем приложение
RUN npm run build

# Production stage with Caddy
FROM caddy:2-alpine

# Копируем собранное приложение
COPY --from=builder /app/dist /usr/share/caddy

# Копируем кастомный Caddyfile (опционально)
COPY Caddyfile.prod /etc/caddy/Caddyfile

EXPOSE 80

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]