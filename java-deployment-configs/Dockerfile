# You can specify a different base image containing Java8, for example:
#   $ docker build . --build-arg BASE_JAVA_IMAGE=frolvlad/alpine-oraclejdk8:slim
#ARG BASE_IMAGE=openshift/java:latest
FROM docker-registry-default.apps.180.222.156.219.xip.io/openshift/java:8
#FROM openjdk:8

# You should specify the full path to the JAR using:
#   $ docker build . --build-arg SERVICE_JAR=/path/to/service.jar
#ARG SERVICE_JAR=./digital-gatekeeper-0.0.7.jar
ARG SERVICE_JAR
#ARG S3_BUCKET_URI=https://s3.ap-south-1.amazonaws.com/cbx-openshift-artefacts

ENV JAVA_OPTS=""
ENV APP_OPTS=""


#WORKDIR /apps/cbx-java-service
WORKDIR /home/jboss

RUN mkdir -p /home/jboss/cbx-java-service
RUN chgrp -R 0 /home/jboss/cbx-java-service && \
    chmod -R g=u /home/jboss/cbx-java-service

RUN chmod g+rwx /home/jboss/cbx-java-service

COPY $SERVICE_JAR /home/jboss/cbx-java-service/cbx-service.jar
#ADD digital-gatekeeper-0.0.7.jar /home/jboss/cbx-java-service/cbx-service.jar

RUN whoami
RUN ls -la /home/jboss
RUN ls -la /home/jboss/cbx-java-service

RUN chgrp -R 0 /home/jboss/cbx-java-service && \
    chmod -R g=u /home/jboss/cbx-java-service

RUN sh -c 'touch /home/jboss/cbx-java-service/cbx-service.jar'
RUN chmod a+rx /home/jboss/cbx-java-service/cbx-service.jar

# Add startup script
COPY start-service.sh /home/jboss/cbx-java-service/start-service.sh
RUN ls -la /home/jboss
RUN chmod a+rx /home/jboss/cbx-java-service/start-service.sh

# Start Java Service
CMD ["/home/jboss/cbx-java-service/start-service.sh"]
