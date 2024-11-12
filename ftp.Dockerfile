FROM fauria/vsftpd

#USER root

COPY ftp.vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ftp.virtual_users.txt /tmp/virtual_users.txt

#RUN chmod +x ftp.add_virtual_users.sh
COPY ftp.add_virtual_users.sh /usr/local/bin/add_virtual_users.sh
RUN chmod +x /usr/local/bin/add_virtual_users.sh

ENTRYPOINT ["/usr/local/bin/add_virtual_users.sh", "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]