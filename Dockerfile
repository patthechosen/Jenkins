FROM ubuntu:latest

# Update and install Apache & Git
RUN apt-get update -y && apt-get install -y apache2 git

# Clone your GitHub repository
RUN git clone https://github.com/patthechosen/Jenkins.git /tmp/repo

# Copy index.html into Apache's web directory
COPY /tmp/repo/index.html /var/www/html/index.html

# Expose port 80
EXPOSE 80

# Start Apache when the container runs
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]