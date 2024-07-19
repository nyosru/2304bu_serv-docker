# Используем базовый образ Python
FROM python:3.10-slim

# Устанавливаем необходимые системные пакеты
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Telethon
RUN pip install telethon

# Копируем скрипт и файл зависимостей в контейнер
WORKDIR /app
COPY . /app

# Запускаем скрипт
CMD ["python", "main.py"]
