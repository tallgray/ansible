FROM alpine/terragrunt
ENV USERNAME=tallgray1
LABEL maintainer="DevOps Admins devops@gdom.local"
EXPOSE 22

RUN apk update; \
    apk add openssh openrc nano; \
    mkdir -p /run/openrc; \
    touch /run/openrc/softlevel; \
    rc-update add sshd; \
    echo -e "PasswordAuthentication yes \n\
    UsePAM yes" >> /etc/ssh/sshd_config

RUN adduser $USERNAME; \
    mkdir /home/$USERNAME/.ssh; \
    touch /home/$USERNAME/.ssh/authorized_keys; \
    chown -r $USERNAME /home/$USERNAME; \
    chmod 700 /home/$USERNAME/.ssh/authorized_keys

COPY key.pub ./key.pub

RUN cat ./key.pub >> /home/$USERNAME/.ssh/authorized_keys

COPY entry_script.sh .

RUN chmod 0777 ./*.sh
