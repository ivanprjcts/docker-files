FROM ubuntu:12.04

ENV LANG C.UTF-8
ENV FECRU_VERSION 2.3.2
ENV FISHEYE_HOME /atlassian/apps/fisheye
ENV FISHEYE_INST /atlassian/data/fisheye

RUN echo "Atlassian - FishEye ${FECRU_VERSION} applications runtime environment"

RUN apt-get update

RUN apt-get install -y software-properties-common

RUN apt-get install -y default-jre

WORKDIR /atlassian/apps

ENV JAVA_HOME /usr/lib/jvm/java-6-openjdk-amd64

#install linux tools
RUN apt-get update && \
  apt-get install -y mc && \
  apt-get install -y nano && \
  apt-get install -y tree && \
  apt-get install -y zip && \
  apt-get install -y wget

#install dev tools
RUN apt-get update && \
  apt-get install -y curl && \
  apt-get install -y git && \
  apt-get install -y mercurial && \
  apt-get install -y subversion && \
  wget -P /usr/bin http://www.perforce.com/downloads/perforce/r15.1/bin.linux26x86_64/p4 && \
  chmod +x /usr/bin/p4

# download and install fisheye to /atlassian/apps/fisheye
ADD http://www.atlassian.com/software/fisheye/downloads/binary/fisheye-${FECRU_VERSION}.zip /atlassian/apps/
# ADD fisheye-${FECRU_VERSION}.zip /atlassian/apps/

RUN unzip fisheye-${FECRU_VERSION}.zip && rm fisheye-${FECRU_VERSION}.zip
RUN mv fecru-${FECRU_VERSION} fisheye
RUN mkdir -p /atlassian/data/fisheye

ADD configure.sh ${FISHEYE_HOME}/
RUN chmod +x ${FISHEYE_HOME}/configure.sh
ADD start.sh ${FISHEYE_HOME}/
RUN chmod +x ${FISHEYE_HOME}/start.sh

EXPOSE 8080

WORKDIR ${FISHEYE_HOME}/

CMD ["./start.sh"]