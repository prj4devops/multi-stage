#!/bin/sh
chmod 755 mvnw
yum -y install java-1.8.0-openjdk-devel
./mvnw clean package
echo $RANDOM > dummy && docker build -t multistage -t multistage:1.0 .
