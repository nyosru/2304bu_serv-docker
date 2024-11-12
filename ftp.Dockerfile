FROM fauria/vsftpd

COPY ftp.vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ftp.virtual_users.txt /tmp/virtual_users.txt
COPY ftp.add_virtual_users.sh /usr/local/bin/add_virtual_users.sh
COPY start.sh /usr/local/bin/start.sh

# Даем права на выполнение скриптов
RUN chmod +x /usr/local/bin/add_virtual_users.sh /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]
