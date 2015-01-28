#!/bin/sh

. ./setenv.sh
sudo docker build -t chnoumis-jenkins:${DOCKER_VERSION} .
