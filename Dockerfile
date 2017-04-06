FROM jenkinsci/jnlp-slave

RUN apt-get update && apt-get install -y mc sudo apt-transport-https ca-certificates curl mc software-properties-common sudo

# docker ce
#RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - &&
#RUN apt-get update apt-get install docker-ce

# docker 1.11.2
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && add-apt-repository "deb [arch=amd64] https://apt.dockerproject.org/repo debian-jessie main"
RUN apt-get update && apt-get install -y docker-engine=1.11.2-0~jessie

