FROM ubuntu:latest

# Update and install Apache & Git
RUN apt-get update -y && apt-get install -y apache2 git

# Clone the repository inside the container
RUN git clone https://github.com/patthechosen/Jenkins.git /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache when the container runs
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]