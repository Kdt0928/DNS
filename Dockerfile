FROM centos:8

EXPOSE 53/udp
EXPOSE 53/tcp

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial && \
    yum -y update && \
    yum install -y bind && \
    /usr/sbin/rndc-confgen -a -b 512 -k rndc-key && \
    chmod 755 /etc/rndc.key

ADD named/named.conf /etc/named.conf
ADD named/example.zone /var/named/example.zone 

CMD ["/usr/sbin/named","-c","/etc/named.conf","-g","-u","named"]