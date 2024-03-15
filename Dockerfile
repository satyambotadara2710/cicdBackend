#!/bin/bash
FROM amazoncorretto:17
WORKDIR /springapp/
COPY . /springapp/
RUN sed -i 's/\r$//' mvnw
RUN ./mvnw clean install
ENTRYPOINT [ "java","-jar","/springapp/target/springbackend.jar" ]