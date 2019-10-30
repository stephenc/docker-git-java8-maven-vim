# Docker Git Java8 Maven VIM

This is a docker image based off the main maven image but with git and vim pre-installed and not running as root.

By default this image will run as a user called `user` with uid and gid of `1000` and a home directory of `/home/user`.

This can be used where your have build tooling that requires a real user account and cannot run as root, for example PostgreSQL.

Docker image available from [DockerHub](https://hub.docker.com/r/stephenc/docker-git-java8-maven-vim)
