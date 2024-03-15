# Start with a base image of Alpine with OpenJDK 17
FROM openjdk:17-jdk-alpine

# Verify Java installation
RUN java -version

# Install wget and tar
RUN apk add wget tar bash

# Install Maven 3.3.1
RUN wget https://archive.apache.org/dist/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.tar.gz -P /tmp && \
    tar -xzvf /tmp/apache-maven-3.3.1-bin.tar.gz -C /opt && \
    ln -s /opt/apache-maven-3.3.1 /opt/maven && \
    rm /tmp/apache-maven-3.3.1-bin.tar.gz

# Set Maven environment variables
ENV M2_HOME=/opt/maven
ENV PATH=${M2_HOME}/bin:${PATH}

#Copy settings.xml
COPY settings.xml /opt/maven/conf/settings.xml

# Verify Maven installation
RUN mvn -version


FROM openjdk:latest

WORKDIR /app

COPY helloworld.jar /app

CMD ["java", "-jar", "helloworld.jar"]
