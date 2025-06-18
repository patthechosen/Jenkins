# Use official Ubuntu base image
FROM ubuntu:20.04

# Avoid interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install necessary tools
RUN apt-get update && \
    apt-get install -y apache2 git curl && \
    apt-get clean

# Add ServerName to avoid Apache startup warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Add startup script to dynamically clone repo and start Apache
COPY start.sh /start.sh
RUN chmod +x /start.sh
# Copy custom index.html into Apache's web root
COPY index.html /var/www/html/index.html

# Expose port 80 for web access
EXPOSE 8080

# Run Apache in foreground and dynamically pull latest content
CMD ["apachectl", "-D", "FOREGROUND"]