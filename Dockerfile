FROM openjdk:8 AS build
LABEL description="Multi-stage build environment"
WORKDIR /tmp
ADD http://worldtimeapi.org/api/ip/asia/seoul created.json
RUN git clone https://github.com/prj4devops/multi-stage.git
WORKDIR /tmp/multi-stage
RUN chmod 755 ./mvnw
RUN ./mvnw clean package

FROM gcr.io/distroless/java:8
LABEL description="Multi-stage sample application"
COPY --from=build /tmp/multi-stage/step1/app-in-step1.jar /opt/app-in-step2.jar
EXPOSE 18080
WORKDIR /opt
ENTRYPOINT [ "java", "-jar", "app-in-step2.jar" ]
