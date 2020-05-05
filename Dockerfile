FROM openjdk:8 AS build
LABEL description="Multi-stage build sample app"
LABEL type="tmp"
WORKDIR /tmp
RUN git clone https://github.com/prj4devops/multi-stage.git && \
chmod 755 ./multi-stage/mvnw && \
./multi-stage/mvnw clean package

FROM gcr.io/distroless/java:8
LABEL description="Running environment for multi-stage sample application"
COPY --from=build /tmp/simple-java-app/target/demo-0.0.1-SNAPSHOT.jar /tmp/demo.jar
EXPOSE 18080
WORKDIR /tmp
ENTRYPOINT [ "java", "-jar", "demo.jar" ]
