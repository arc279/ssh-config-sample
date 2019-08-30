FROM centos:7
LABEL maintainer Motonobu Kuryu <revision279@gmail.com>

RUN yum install -y openssh-server openssh-clients
RUN ssh-keygen -A
RUN sed -i 's/^#\(AllowAgentForwarding yes\)/\1/' /etc/ssh/sshd_config

RUN useradd hoge -m

