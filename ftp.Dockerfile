FROM centos:7

ARG USER_ID=14
ARG GROUP_ID=50
ARG SERVER_IP

#ENV PHPGROUP=${PHPGROUP}
#ENV PHPUSER=${PHPUSER}
ENV SERVER_IP=${SERVER_IP}


RUN yum -y update && yum clean all
RUN yum install -y \
	vsftpd \
	db4-utils \
	db4 \
	iproute && yum clean all

RUN usermod -u ${USER_ID} ftp
RUN groupmod -g ${GROUP_ID} ftp

ENV FTP_USER user1
ENV FTP_PASS password1
ENV PASV_ADDRESS ${SERVER_IP}
ENV PASV_ADDR_RESOLVE NO
ENV PASV_ENABLE YES
ENV PASV_MIN_PORT 21100
ENV PASV_MAX_PORT 21110
ENV XFERLOG_STD_FORMAT NO
ENV LOG_STDOUT **Boolean**
ENV FILE_OPEN_MODE 0666
ENV LOCAL_UMASK 077
ENV REVERSE_LOOKUP_ENABLE YES
ENV PASV_PROMISCUOUS NO
ENV PORT_PROMISCUOUS NO

COPY vsftpd.conf /etc/vsftpd/
COPY vsftpd_virtual /etc/pam.d/
COPY run-vsftpd.sh /usr/sbin/

RUN chmod +x /usr/sbin/run-vsftpd.sh
#RUN mkdir -p /home/vsftpd/
RUN mkdir -p /home_ftp3/
#RUN chown -R ftp:ftp /home/vsftpd/
RUN chown -R ftp:ftp /home_ftp3/

#VOLUME /home/vsftpd
VOLUME /home_ftp3
#VOLUME /var/log/vsftpd

EXPOSE 20 21

CMD ["/usr/sbin/run-vsftpd.sh"]