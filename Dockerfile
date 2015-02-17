FROM jenkins:1.596

MAINTAINER chnoumis <it@chnoumis.com>

USER root
RUN apt-get update && apt-get install -y sudo maven ruby libaio1 libaio-dev
RUN echo 'jenkins ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
# Install docker
RUN sh -c "curl https://get.docker.io/gpg | apt-key add -" && \
sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list" && \ 
apt-get update && apt-get install -y lxc-docker-1.4.1

# Font installation 
echo "deb http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ saucy multiverse" | sudo tee -a /etc/apt/sources.list && \
echo "deb-src http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ saucy multiverse" | sudo tee -a /etc/apt/sources.list && \
echo "deb http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ saucy-updates multiverse" | sudo tee -a /etc/apt/sources.list && \
echo "deb-src http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ saucy-updates multiverse" | sudo tee -a /etc/apt/sources.list && \
apt-get update
# preselect yes for ms EULA
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections && \
apt-get install -y ttf-mscorefonts-installer

USER jenkins

COPY jenkins-pre.sh  /usr/local/bin/jenkins-pre.sh

ENTRYPOINT ["/usr/local/bin/jenkins-pre.sh"]