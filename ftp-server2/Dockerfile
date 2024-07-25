FROM fauria/vsftpd

# Копируем файл с пользователями и сценарий в контейнер
COPY ./ftp_users.txt /etc/vsftpd/ftp_users.txt
COPY ./add_ftp_users.sh /usr/local/bin/add_ftp_users.sh

# Делаем сценарий исполняемым и запускаем его
RUN chmod +x /usr/local/bin/add_ftp_users.sh && \
    /usr/local/bin/add_ftp_users.sh /etc/vsftpd/ftp_users.txt
