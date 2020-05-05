FROM openjdk:8 AS build
LABEL description="Multi-stage build environment"
LABEL type="tmp"
WORKDIR /tmp
COPY dummy .
RUN git clone https://github.com/prj4devops/multi-stage.git
WORKDIR /tmp/multi-stage
RUN chmod 755 ./mvnw 
RUN ./mvnw clean package
RUN ./target/demo-0.0.1-SNAPSHOT.jar /tmp

FROM gcr.io/distroless/java:8
LABEL description="Multi-stage sample application"
COPY --from=build /tmp/demo-0.0.1-SNAPSHOT.jar /tmp/demo.jar
EXPOSE 18080
WORKDIR /tmp
ENTRYPOINT [ "java", "-jar", "demo.jar" ]
