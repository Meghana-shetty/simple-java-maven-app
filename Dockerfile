FROM maven:latest AS build
WORKDIR /app
COPY . .
COPY src ./src
RUN mvn package -DskipTests

FROM tomcat:latest
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build/app/target/*.war usr/local/tomcat/webapps/new.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

# https://github.com/Meghana-shetty/simple-java-maven-app

# FROM maven:3.9.9-eclipse-temurin-17 AS build

# # Set working directory inside the image
# WORKDIR /app

# # Copy the Maven project files into the image
# COPY pom.xml .
# COPY src ./src

# # Build the WAR file (skip tests if desired)
# RUN mvn clean package -DskipTests

# # ---------------------------------------------
# # Stage 2: Run the WAR file in Tomcat
# # ---------------------------------------------
# FROM tomcat:9.0-jdk17-temurin

# # Remove default Tomcat applications (optional)
# RUN rm -rf /usr/local/tomcat/webapps/*

# # Copy the generated WAR from the Maven build stage
# COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# # Expose Tomcat's port
# EXPOSE 8080

# # Start Tomcat when the container runs
# CMD ["catalina.sh", "run"]
