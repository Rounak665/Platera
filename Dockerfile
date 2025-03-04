# Use Maven to build the project and Tomcat to run it
FROM maven:3.8.7-eclipse-temurin-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src

# Build the WAR file
RUN mvn clean package

# Use Tomcat as the base image to run the app
FROM tomcat:9.0

# Copy the generated WAR file from the build stage to Tomcat webapps
COPY --from=build /app/target/Platera-Main.war /usr/local/tomcat/webapps/Platera-Main.war


# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
