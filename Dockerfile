FROM openjdk:11-jdk-slim

EXPOSE 1082 8082

CMD ["java", "-agentlib:jdwp=transport=dt_socket,address=*:1082,server=y,suspend=n", "-Xmx512m", "-jar", "/app/osbb-api.jar"]

ADD ./target/osbb-api.jar /app/
