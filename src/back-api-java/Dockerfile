FROM maven

COPY . /opt/app

WORKDIR /opt/app

RUN mvn clean install

EXPOSE 8080

CMD ["java", "-jar", "target/foolishness-0.0.1-SNAPSHOT.jar"]