# Используем базовый образ Python
FROM python:3.9-slim

# Устанавливаем FFmpeg
RUN apt-get update && apt-get install -y ffmpeg

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем зависимости
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем исходный код
COPY . .

# Открываем порт для веб-сервера
EXPOSE 5000

# Запускаем сервер
CMD ["python", "server.py"]