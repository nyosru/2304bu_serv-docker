# Используйте образ с Python
FROM python:3.9-slim

# Установите рабочую директорию в контейнере
WORKDIR /app

# Скопируйте файл requirements.txt и установите зависимости
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Скопируйте код приложения в контейнер
COPY . .

# Определите команду запуска приложения
CMD ["python", "app.py"]
