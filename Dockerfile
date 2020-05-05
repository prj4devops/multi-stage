FROM openjdk:8 AS build
LABEL description="Multi-stage build environment"
LABEL type="tmp"
WORKDIR /tmp
RUN git clone https://github.com/prj4devops/multi-stage.git && \
chmod 755 ./multi-stage/mvnw && \
./multi-stage/mvnw clean package

FROM gcr.io/distroless/java:8
LABEL description="multi-stage sample application"
COPY --from=build /tmp/multi-stage/target/demo-0.0.1-SNAPSHOT.jar /tmp/demo.jar
EXPOSE 18080
WORKDIR /tmp
ENTRYPOINT [ "java", "-jar", "demo.jar" ]
