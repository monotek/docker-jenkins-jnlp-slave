FROM openjdk:8-jdk
MAINTAINER André Bauer <monotek23@gmail.com>

# set home dir
ENV HOME /home/jenkins

# set jenkins version
ARG VERSION=3.7

# create jenkins user
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins

# install dependencies
RUN apt-get update && apt-get install -y apt-transport-https binfmt-support ca-certificates curl mc qemu-user-static software-properties-common sudo

# install slave.jar
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

# remove debian docker
RUN apt-get -y remove docker.io

# install docker ce
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install docker-ce

# cleanup
RUN apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

RUN mkdir /home/jenkins/.jenkins
VOLUME /home/jenkins/.jenkins
WORKDIR /home/jenkins

COPY jenkins-slave /usr/local/bin/jenkins-slave

ENTRYPOINT ["/usr/local/bin/jenkins-slave"]
