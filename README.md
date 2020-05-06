# Docker Git Java8 Maven VIM

This is a docker image based off the main maven image but with git and vim and some other common build tools pre-installed and not running as root.

By default this image will run as a user called `user` with uid and gid of `1000` and a home directory of `/home/user`. 
The default working directory is `/home/user/src`
If you want to bind mount a project to build, we recommend mounting it at `/home/user/src` 

This can be used where your have build tooling that requires a real user account and cannot run as root, for example PostgreSQL.

Docker image available from [DockerHub](https://hub.docker.com/r/stephenc/docker-git-java8-maven-vim)

# About pre-seeding

This docker image has some pre-seeded dependencies included to make some builds faster.

Each set of plugins / dependencies should be in their own project directory named `seed-...` as a sub-folder of the [`seed`](./seed/) directory.
Separate projects are used so that multiple versions can be seeded.
Projects start with a three digit grouping prefix so that we can control the order in which seeds are loaded, which doesn't affect the final image but makes it easier to determine whether seeds are effectively seeding the artifacts that they should.