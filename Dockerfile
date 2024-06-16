FROM maven:3.9.7-amazoncorretto-8-debian-bookworm AS build
WORKDIR /app
COPY pom.xml ./
copy src ./src

RUN mvn package

FROM openjdk:24-slim-bullseye
COPY --from=build /app/target/*.jar ./app.jar

EXPOSE 8080
ENV PORT 8080
CMD ["java", "-jar", "app.jar"]
