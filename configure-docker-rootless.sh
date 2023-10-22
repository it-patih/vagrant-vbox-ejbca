#!/bin/bash

echo "###"
echo "### configure-docker-rootless.sh ###"
echo `id`
echo "###"

echo "> Install dockerd-rootless-setuptool.sh"
ssh -q -o StrictHostKeyChecking=no microk8s@localhost /usr/bin/dockerd-rootless-setuptool.sh install

echo "> Configure variables for rootless docker"
microk8sUID=`id -u microk8s`
ssh -q -o StrictHostKeyChecking=no microk8s@localhost bash -c "'
echo \"\" >> ~/.bashrc
echo \"\" >> ~/.bashrc
echo \"# Environment variables definition.\" >> ~/.bashrc
echo \"DOCKER_HOST=unix:///run/user/$microk8sUID/docker.sock\" >> ~/.bashrc
'"

echo "> Launch daemon on system startup"
ssh -q -o StrictHostKeyChecking=no microk8s@localhost bash -c "'
systemctl --user enable docker
'"
sudo loginctl enable-linger microk8s
