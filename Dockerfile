FROM jenkins:1.596

MAINTAINER chnoumis <it@chnoumis.com>

USER root
RUN apt-get update && apt-get install -y sudo maven ruby libaio1 libaio-dev
RUN echo 'jenkins ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
USER jenkins

COPY jenkins-pre.sh  /usr/local/bin/jenkins-pre.sh

ENTRYPOINT ["/usr/local/bin/jenkins-pre.sh"]