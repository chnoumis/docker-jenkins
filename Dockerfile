FROM jenkins:1.596

MAINTAINER chnoumis

ENV DOCKER_VERSION 1.4.1
ENV KUBERNETES_VERSION 0.11.0

USER root
RUN apt-get update && apt-get install -y sudo maven ruby libaio1 libaio-dev
RUN echo 'jenkins ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
# Install docker
RUN sh -c "curl https://get.docker.io/gpg | apt-key add -" && \
sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list" && \ 
apt-get update && apt-get install -y lxc-docker-${DOCKER_VERSION}

# Font installation 
RUN echo "deb http://ftp.de.debian.org/debian sid main contrib" | tee -a /etc/apt/sources.list && \
apt-get update
# preselect yes for ms EULA
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
apt-get install -y ttf-mscorefonts-installer

# Kubernetes installation
RUN cd /opt && wget https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/kubernetes-server-linux-amd64.tar.gz && \
    tar -zxvf  kubernetes-server-linux-amd64.tar.gz && \
    rm kubernetes-server-linux-amd64.tar.gz && \
    chmod -R 777 /opt/kubernetes    

USER jenkins

COPY jenkins-pre.sh  /usr/local/bin/jenkins-pre.sh

ENTRYPOINT ["/usr/local/bin/jenkins-pre.sh"]