#!/bin/sh
#set -x 

# Registry service bindings
if [ ! -z "$REGISTRY_HOSTNAME" ]; then
   export SVC_URI_REGISTRY="${REGISTRY_PROTOCOL}://${REGISTRY_USERNAME}:${REGISTRY_PASSWORD}@${REGISTRY_HOSTNAME}:${REGISTRY_PORT}/eureka/"
   APP_OPTS="$APP_OPTS -Deureka.client.serviceUrl.defaultZone=$SVC_URI_REGISTRY"
fi

# Git service bindings
if [ ! -z "$GIT_HOSTNAME" ]; then
   export SVC_URI_GIT="${GIT_PROTOCOL}://${GIT_USERNAME}:${GIT_PASSWORD}@${GIT_HOSTNAME}:${GIT_PORT}/${GIT_REPOSITORY}"
   APP_OPTS="$APP_OPTS -Dspring.cloud.config.server.git.uri=${GIT_PROTOCOL}://git@${GIT_HOSTNAME}/${GIT_REPOSITORY}"
fi

# Elasticsearch service bindings
if [ ! -z "$ELASTICSEARCH_HOSTNAME" ]; then
   if [ ! -z "$ELASTICSEARCH_USERNAME" ]; then
      export SVC_URI_ELASTICSEARCH="${ELASTICSEARCH_PROTOCOL}://${ELASTICSEARCH_USERNAME}:${ELASTICSEARCH_PASSWORD}@${ELASTICSEARCH_HOSTNAME}:${ELASTICSEARCH_PORT}"       
   else
      export SVC_URI_ELASTICSEARCH="${ELASTICSEARCH_PROTOCOL}://${ELASTICSEARCH_HOSTNAME}:${ELASTICSEARCH_PORT}"
   fi
   
   # For call urrent Action API's , Will be removed later , Helps in minimising rework
   APP_OPTS="$APP_OPTS -DES.DB.User=${ELASTICSEARCH_USERNAME} -DES.DB.Password=${ELASTICSEARCH_PASSWORD} -DES.DB.Host=${ELASTICSEARCH_HOSTNAME} -DES.DB.Port=${ELASTICSEARCH_PORT}"
   
fi

# RabbitMQ service bindings
if [ ! -z "$RABBITMQ_HOSTNAME" ]; then
   export SVC_URI_RABBITMQ="${RABBITMQ_PROTOCOL}://${RABBITMQ_USERNAME}:${RABBITMQ_PASSWORD}@${RABBITMQ_HOSTNAME}:${RABBITMQ_PORT}/${RABBITMQ_VHOST}"
   
   # For call urrent Action API's , Will be removed later , Helps in minimising rework
   APP_OPTS="$APP_OPTS -DDigital.RabbitMQ.Host=${RABBITMQ_HOSTNAME} -DDigital.RabbitMQ.Port=${RABBITMQ_PORT} -DDigital.RabbitMQ.User=${RABBITMQ_USERNAME} -DDigital.RabbitMQ.Password=${RABBITMQ_PASSWORD} -DDigital.RabbitMQ.VHost=${RABBITMQ_VHOST}"
fi

# Redis service bindings[[[[[[]]]]]]
if [ ! -z "$REDIS_HOSTNAME" ]; then
   if [ ! -z "$REDIS_PASSWORD" ]; then
   export SVC_URI_REDIS="${REDIS_PROTOCOL}://${REDIS_PASSWORD}@${REDIS_HOSTNAME}:${REDIS_PORT}"
   else
   export SVC_URI_REDIS="${REDIS_PROTOCOL}://${REDIS_HOSTNAME}:${REDIS_PORT}"
   fi
   APP_OPTS="$APP_OPTS -DRedis.DB.Url=${REDIS_HOSTNAME}:${REDIS_PORT} -DRedis.DB.Password=$REDIS_PASSWORD"
 

fi

# Kafka service bindings
if [ ! -z "$KAFKA_HOSTNAME" ]; then
   export SVC_URI_KAFKA="${KAFKA_PROTOCOL}://${KAFKA_USERNAME}:${KAFKA_PASSWORD}@${KAFKA_HOSTNAME}:${KAFKA_PORT}"
   
   APP_OPTS="$APP_OPTS -Dkafka.config.bootstrapservers=${KAFKA_HOSTNAME}:${KAFKA_PORT}"
fi



java $JAVA_OPTS $APP_OPTS -Djava.security.egd=file:/dev/./urandom -jar /home/cbx-java-service/cbx-service.jar