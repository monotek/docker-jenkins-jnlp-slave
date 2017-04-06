FROM openjdk:8-jdk
MAINTAINER André Bauer <monotek23@gmail.com>

ENV HOME /home/jenkins

LABEL Description="This is a base image, which provides the Jenkins agent executable (slave.jar)" Vendor="Jenkins project" Version="3.7"

ARG VERSION=3.7

# create jenkins user
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins

# install slave.jar
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

# install dependencies
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates software-properties-common mc sudo 

# install apt keys & repos for docker-engine & docker-ce
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - &&
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && add-apt-repository "deb [arch=amd64] https://apt.dockerproject.org/repo debian-jessie main"

# remove debian docker
RUN apt-get remove docker.io

# install docker ce
#RUN apt-get install docker-ce

# install docker 1.11.2
RUN apt-get install -y docker-engine=1.11.2-0~jessie

COPY jenkins-slave /usr/local/bin/jenkins-slave

USER jenkins
RUN mkdir /home/jenkins/.jenkins
VOLUME /home/jenkins/.jenkins
WORKDIR /home/jenkins

ENTRYPOINT ["jenkins-slave"]
