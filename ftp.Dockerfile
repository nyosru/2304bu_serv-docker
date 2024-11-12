FROM fauria/vsftpd

# Копируем конфигурационные файлы
COPY ftp.vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ftp.virtual_users.txt /tmp/virtual_users.txt
COPY ftp.add_virtual_users.sh /usr/local/bin/add_virtual_users.sh

# Назначаем права на выполнение скрипта
RUN chmod +x /usr/local/bin/add_virtual_users.sh

# Запускаем скрипт для добавления пользователей, а затем FTP-сервер
ENTRYPOINT ["/bin/sh", "-c", "/usr/local/bin/add_virtual_users.sh && /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf"]
