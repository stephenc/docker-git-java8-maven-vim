#
# Java 1.8 & Maven Dockerfile
#
# https://github.com/jamesdbloom/docker_java8_maven
#

# pull base image.
FROM java:8

# maintainer details
MAINTAINER Stephen Connolly "stephen.ala.connolly@gmail.com"

# update packages and install maven
RUN  \
  export DEBIAN_FRONTEND=noninteractive && \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
      apt-get update && \
        apt-get -y upgrade && \
          apt-get install -y vim wget curl git maven

# attach volumes
VOLUME /volume/git

COPY vimrc /root/.vimrc
COPY vim /root/.vim

# create working directory
RUN mkdir -p /local/git
WORKDIR /local/git

# run terminal
CMD ["/bin/bash"]
