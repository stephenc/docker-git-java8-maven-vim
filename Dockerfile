#
# Java 1.8 & Maven Dockerfile
#
# https://github.com/jamesdbloom/docker_java8_maven
#

ARG MAVEN_VERSION=3.6.1-jdk-8

# pull base image.
FROM maven:${MAVEN_VERSION}

ARG USER_UID=1000
ARG USER_GID=1000
ARG USER_NAME=user

# maintainer details
MAINTAINER Stephen Connolly "stephen.alan.connolly@gmail.com"

# update packages and install maven
RUN  set -eux; \
  export DEBIAN_FRONTEND=noninteractive; \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list ;\
  apt-get update ;\
  apt-get -y upgrade ;\
  apt-get install -y vim wget curl git ;\
  rm -rf /var/lib/apt/lists/*

RUN set -eux; \
  groupadd -g ${USER_GID} ${USER_NAME}; \
  useradd -u ${USER_UID} -d /home/${USER_NAME} -g ${USER_NAME} ${USER_NAME}; \
  mkdir -p /home/${USER_NAME}; \
  chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}

COPY vimrc /root/.vimrc
COPY vim /root/.vim

RUN set -eux; \
  cp -R /root/.vim* /home/${USER_NAME}; \
  chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}/.vim*

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}
ENV MAVEN_CONFIG "/home/${USER_NAME}/.m2"

COPY pom.xml "/home/${USER_NAME}"
RUN set -eux; \
  mkdir -p "/home/${USER_NAME}/.ssh"; \
  chmod -R 700 "/home/${USER_NAME}/.ssh"; \
  ssh-keyscan github.com >> ~/.ssh/known_hosts; \
  mvn deploy site release:clean clean; \
  rm -rvf pom.xml "/home/${USER_NAME}/.m2/repository/localdomain"; \
  find "/home/${USER_NAME}/.m2/repository/" -name _remote.repositories -exec rm -vf {} \;
