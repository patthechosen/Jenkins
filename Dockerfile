# Specify the base image
FROM ubuntu:latest
# Update all packages
RUN apt-get update -y && apt-get install -y apache2
# Copy the app inside the container
COPY index.html /var/www/html/
# Expose port where the app is running
EXPOSE 80
# Start Apache in the foreground
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]