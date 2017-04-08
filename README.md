# jnlp-slave with docker-ce and support for arm docker containers

## run via:

* docker run --privileged -ti -v /run/docker.sock:/run/docker.sock monotek/jnlp-slave

## to run arm docker contrainer inside jenkins slave:

* docker run -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static armbuild/debian uname -a

## Dockerhub Image:

* https://hub.docker.com/r/monotek/jnlp-slave/

## If you Docker host is CentOS you have to:

* install /usr/bin/qemu-arm-static
* run "update-binfmts --enable qemu-arm" from the jenkins slave docker container
