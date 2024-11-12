FROM fauria/vsftpd

# Копируем файлы конфигурации
COPY ftp.vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ftp.virtual_users.txt /tmp/virtual_users.txt

# Копируем и назначаем права для скрипта
COPY ftp.add_virtual_users.sh /usr/local/bin/add_virtual_users.sh
RUN chmod +x /usr/local/bin/add_virtual_users.sh

# Используем ENTRYPOINT для запуска скрипта и сервера
ENTRYPOINT ["/usr/local/bin/add_virtual_users.sh", "&&", "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
