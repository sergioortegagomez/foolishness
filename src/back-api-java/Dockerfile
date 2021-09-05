FROM maven AS builder

COPY . .
RUN mvn package

FROM openjdk:11
COPY --from=builder target/foolishness-0.0.1-SNAPSHOT.jar /foolishness-0.0.1-SNAPSHOT.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/foolishness-0.0.1-SNAPSHOT.jar"]