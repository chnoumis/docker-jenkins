#! /bin/bash

cd /etc/jenkins/certs
sudo cp -r * /usr/local/share/ca-certificates/
sudo update-ca-certificates

exec /usr/local/bin/jenkins.sh