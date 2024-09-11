# Используем официальный Python образ как базовый
FROM python:3.9-slim

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем требования в контейнер
COPY requirements.txt .

# Устанавливаем Python зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код приложения в контейнер
COPY . .

# Открываем порт, на котором будет работать приложение
EXPOSE 5000

# Определяем команду для запуска приложения
CMD ["python", "parse_events.py"]
