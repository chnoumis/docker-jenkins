#! /bin/bash

# Certificate installation
cd /etc/jenkins/certs
sudo cp -r * /usr/local/share/ca-certificates/
sudo update-ca-certificates

# Maven installation
cp /etc/jenkins/m2/settings.xml /var/jenkins_home/.m2/settings.xml
 	
exec /usr/local/bin/jenkins.sh