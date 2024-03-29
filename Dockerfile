#!/bin/bash
FROM amazoncorretto:17 as builder
WORKDIR /app/
COPY ./.mvn /app/.mvn
COPY pom.xml mvnw /app/
RUN sed -i 's/\r$//' mvnw && ./mvnw dependency:go-offline
COPY . /app/
RUN  sed -i 's/\r$//' mvnw && ./mvnw clean install

FROM amazoncorretto:17
WORKDIR /app/
COPY --from=builder /app/target/springbackend.jar /app/backend.jar
ENTRYPOINT [ "java","-jar","/app/backend.jar" ]