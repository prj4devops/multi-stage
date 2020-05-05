FROM openjdk:8 AS build
LABEL description="Multi-stage build sample app"
WORKDIR /tmp
RUN git clone https://github.com/prj4devops/simple-java-app.git
WORKDIR /tmp/simple-java-app
RUN git checkout multi-stage
RUN chmod u+x mvnw
RUN ./mvnw clean package

FROM gcr.io/distroless/java:8
LABEL description="Running environment for sample application"
COPY --from=build /tmp/simple-java-app/target/demo-0.0.1-SNAPSHOT.jar /tmp/demo.jar
EXPOSE 18080
WORKDIR /tmp
ENTRYPOINT [ "java", "-jar", "demo.jar" ]
