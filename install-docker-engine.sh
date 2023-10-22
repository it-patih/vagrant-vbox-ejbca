#!/bin/bash

echo "###"
echo "### install-docker-engine.sh ###"
echo `id`
echo "###"

DEBIAN_FRONTEND=noninteractive apt-get -yq update

echo "> Uninstall old versions of Docker Engine"
DEBIAN_FRONTEND=noninteractive apt-get -yq remove docker docker-engine docker.io containerd runc

echo "> Set up the repository of Docker Engine"
DEBIAN_FRONTEND=noninteractive apt-get -yq install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
DEBIAN_FRONTEND=noninteractive apt-get -yq update

echo "> Install docker engine: docker-ce, docker-ce-cli, containered.io"
DEBIAN_FRONTEND=noninteractive apt-get -yq install docker-ce docker-ce-cli containerd.io

echo "> Install docker engine: docker-ce-rootless-extras"
DEBIAN_FRONTEND=noninteractive apt-get -yq install docker-ce-rootless-extras
docker run hello-world

echo "> Disable system-wide Docker daemon"
systemctl disable --now docker.service docker.socket


