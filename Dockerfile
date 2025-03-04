# Use Tomcat as the base image
FROM tomcat:9.0

# Copy the WAR file into Tomcat's webapps directory
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
