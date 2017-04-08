# debian jessie jenkins jnlp-slave with docker-ce and support for arm docker containers

## If your on Debian/Ubuntu:

* apt-get update;apt-get install qemu-user-static binfmt-support

## If your Docker host is CentOS you have to:

* cp qemu-arm-static to /usr/bin/qemu-arm-static
* if you use your own entrypoint get sure "update-binfmts --enable qemu-arm" is executed before starting docker arm containers

## run the jenkins slave via:

* docker run --privileged -ti -v /run/docker.sock:/run/docker.sock monotek/jnlp-slave -url http://jenkins-server:port <secret> <agent name>

## to run arm docker contrainer inside jenkins slave:

* docker run -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static armbuild/debian uname -a
