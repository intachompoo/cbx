# You can specify a different base image containing Java8, for example:
#   $ docker build . --build-arg BASE_JAVA_IMAGE=frolvlad/alpine-oraclejdk8:slim
#ARG BASE_IMAGE=openshift/java:latest
#ARG BASE_IMAGE=docker-registry-default.apps.180.222.156.219.xip.io/openshift/java:8
#FROM ${BASE_IMAGE}
FROM docker-registry-default.apps.180.222.156.219.xip.io/openshift/java:8
#FROM oracle/openjdk:8

# You should specify the full path to the JAR using:
#   $ docker build . --build-arg SERVICE_JAR=/path/to/service.jar
ARG SERVICE_JAR
#ARG S3_BUCKET_URI=https://s3.ap-south-1.amazonaws.com/cbx-openshift-artefacts

ENV JAVA_OPTS=""
ENV APP_OPTS=""

WORKDIR /cbx-java-service

USER root
RUN chmod g+rwx /cbx-java-service

USER jboss
ADD  ${SERVICE_JAR} /cbx-java-service/cbx-service.jar

USER root
RUN sh -c 'touch /cbx-java-service/cbx-service.jar'
RUN chmod a+rx /cbx-java-service/cbx-service.jar

RUN ls -la /cbx-java-service/

# Add startup script
#ADD $S3_BUCKET_URI/java-services/start-service.sh /cbx-java-service/start-service.sh
USER jboss
ADD start-service.sh /cbx-java-service/start-service.sh
USER root
RUN chmod a+rx /cbx-java-service/start-service.sh

# Start Java Service
USER jboss
CMD ["/cbx-java-service/start-service.sh"]

