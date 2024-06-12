#!/bin/sh

# Запускаем cron в фоновом режиме
cron

# Печатаем логи cron
tail -f /var/log/cron/cron.log
