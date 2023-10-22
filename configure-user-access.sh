#!/bin/bash

echo "###"
echo "### configure-user-access.sh ### "
echo `id`
echo "###"

NOW=$(date +"%Y%m%d-%H%M%S")

echo "> Add public key of operator to login to user vagrant"
cp /home/vagrant/.ssh/authorized_keys /home/vagrant/.ssh/authorized_keys.$NOW
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys.$NOW
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCc/JpeqhJWZIPjqakdjLu2PcuS/aEV8RYHeJj+R4q+nIHYNVMiC8f7y2oeWSgHebrUFqoRG9Le0GNf0TXtSIafjNPNCvOvLhZX+ghNozFJ47OUfjeGGv26al+bF2tzS9ETqmmFI7gTTGrP5j+D9BG3k6RMrWHSU+3oSFJxnthMeCqa7SWPxmLZ94cUF3HYhXE8P/Bfw7bkyMY8SC1zA9o2vag2qdoKFJN3LE4KxRX3MTG6H4gfVy5z8o+4taF3W/hspcmRxOUN7YDwh+Q2CPDLDkqXheqQePXaGAdqmwf0atdI4hjA7kvqcQeGIgRRg36luUVonivJc3Ht7wnlup/t operator" >> /home/vagrant/.ssh/authorized_keys

echo "> Create and configure new user microk8s"
useradd -m -s /bin/bash microk8s
cp /home/microk8s/.bashrc /home/microk8s/.bashrc.$NOW
chown microk8s:microk8s /home/microk8s/.bashrc.$NOW

echo "> Configure group for user vagrant and user microk8s"
usermod -aG sudo microk8s
usermod -aG microk8s microk8s
usermod -aG microk8s vagrant

echo "> Add public key of user vagrant to login to user microk8s"
ssh-keygen -q -t rsa -N '' -f /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa /home/vagrant/.ssh/id_rsa.pub
mkdir /home/microk8s/.ssh
chown microk8s:microk8s /home/microk8s/.ssh
cp /home/vagrant/.ssh/id_rsa.pub /home/microk8s/.ssh/authorized_keys
chown microk8s:microk8s /home/microk8s/.ssh/authorized_keys