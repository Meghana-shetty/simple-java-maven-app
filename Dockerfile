FROM maven:latest
WORKDIR /app
COPY . .
RUN mvn package

FROM tomcat:latest
COPY $WORKSPACE/app/*.war /opt/tomcat/new.war
CMD ["catalina.sh", "run"]

https://github.com/Meghana-shetty/simple-java-maven-app
