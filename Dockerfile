
FROM maven:3.6.3-openjdk-14-slim AS build
RUN mkdir -p /teste
WORKDIR /teste
COPY pom.xml /teste
COPY src /teste/src
RUN mvn -B package --file pom.xml -DskipTests

FROM openjdk:14-slim
COPY --from=build /teste/target/*jar-with-dependencies.jar app.jar
EXPOSE 6379
ENTRYPOINT ["java","-jar","app.jar"]
