#!/bin/bash

echo "###"
echo "### install-ejbca.sh ###"
echo `id`
echo "###"

mkdir -p /vagrant/.ejbca

ssh -q -o StrictHostKeyChecking=no microk8s@localhost << EOF
	ln -sfn /vagrant/.ejbca /home/microk8s/.ejbca
	docker pull keyfactor/ejbca-ce
	docker run -d --name ejbca --rm -p 8080:8080 -p 8443:8443 -h localhost -v /home/microk8s/.ejbca/persistent:/mnt/persistent -e \'TLS_SETUP_ENABLED="true"\' -e \'DATABASE_JDBC_URL="jdbc:h2:/mnt/persistent/ejbcadb;DB_CLOSE_DELAY=-1"\' keyfactor/ejbca-ce
EOF
