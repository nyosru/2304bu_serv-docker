#!/bin/bash
chmod +x /usr/local/bin/add_virtual_users.sh
/usr/local/bin/add_virtual_users.sh
exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
