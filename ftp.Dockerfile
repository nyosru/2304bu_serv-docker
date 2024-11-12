FROM fauria/vsftpd

# Копируем файлы и назначаем права на выполнение
COPY ftp.vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ftp.virtual_users.txt /tmp/virtual_users.txt
COPY ftp.add_virtual_users.sh /usr/local/bin/add_virtual_users.sh

RUN chmod +x /usr/local/bin/add_virtual_users.sh

# Используем ENTRYPOINT для запуска скрипта и FTP-сервера
ENTRYPOINT ["/bin/sh", "-c", "/usr/local/bin/add_virtual_users.sh && /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf"]
