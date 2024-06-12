# Используем базовый образ (например, Debian)
FROM debian:latest

# Обновляем пакеты и устанавливаем cron, curl и procps
RUN apt-get update && apt-get install -y cron curl procps iputils-ping

# Копируем crontab файл и добавляем его в cron-таблицу
COPY cron/my-crontab /etc/cron.d/my-crontab

# Даем права на выполнение crontab файла
RUN chmod 0644 /etc/cron.d/my-crontab

# Добавляем cron-таблицу в cron и запускаем cron
RUN crontab /etc/cron.d/my-crontab

# Создаем папку для логов
RUN mkdir -p /var/log/cron
#RUN mkdir /var/log/cron
#RUN chmod 0777 /var/log/cron/cron.log



# Копируем скрипт запуска
COPY cron/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Запускаем скрипт
ENTRYPOINT ["/entrypoint.sh"]
