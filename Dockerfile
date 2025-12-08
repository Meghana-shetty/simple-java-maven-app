# ----------------------------
# Stage 1: Build the application
# ----------------------------
FROM maven:latest

# Set working directory inside the container
WORKDIR /app

# Copy Maven configuration and source code
COPY pom.xml .
COPY src ./src

# Build the JAR file
RUN mvn clean package -DskipTests

# ----------------------------
# Stage 2: Run the application
# ----------------------------
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port your application listens on
EXPOSE 8080

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]


# or below code 

# # Stage 1: Build the application
# FROM maven:latest AS build
# WORKDIR /app
# COPY pom.xml .
# COPY src ./src
# RUN mvn clean package -DskipTests

# # Stage 2: Run the application
# FROM eclipse-temurin:latest
# WORKDIR /app
# COPY --from=build /app/target/*.jar app.jar
# EXPOSE 8080
# ENTRYPOINT ["java", "-jar", "app.jar"]

# here, if main app continiously runs then only we can get the application in exposed port. else can't as this is java jar


*******************************
# Stage 1: Build
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn -B clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the built JAR (use wildcard safely — matches exactly one file)
COPY --from=build /app/target/*.jar app.jar

# Expose port only if your app listens on one (e.g. Spring Boot)
# EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

