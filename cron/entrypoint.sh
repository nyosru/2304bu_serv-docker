#!/bin/sh

# Запускаем cron в фоновом режиме
cron

# Печатаем crontab для отладки
echo "Current crontab:"
crontab -l

# Печатаем процессы для отладки
echo "Current processes:"
ps aux

# Печатаем логи cron
tail -f /var/log/cron/cron.log
