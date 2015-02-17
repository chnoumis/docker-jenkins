FROM jenkins:1.596

MAINTAINER chnoumis <it@chnoumis.com>

USER root
RUN apt-get update && apt-get install -y sudo maven ruby libaio1 libaio-dev ttf-mscorefonts-installer
RUN echo 'jenkins ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
# Install docker
RUN sh -c "curl https://get.docker.io/gpg | apt-key add -" && \
sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list" && \ 
apt-get update && apt-get install -y lxc-docker-1.4.1
USER jenkins

COPY jenkins-pre.sh  /usr/local/bin/jenkins-pre.sh

ENTRYPOINT ["/usr/local/bin/jenkins-pre.sh"]