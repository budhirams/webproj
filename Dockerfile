FROM ubuntu:22.04
MAINTAINER budhiramsahani421@gmail.com

# Install Apache2, wget, zip, and unzip
RUN apt update && apt install -y apache2 wget zip unzip && rm -rf /var/lib/apt/lists/*
# Set ServerName to suppress the warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

WORKDIR /var/www/html

# Download the template inside the container
RUN wget --retry-connrefused --waitretry=5 --timeout=30 -t 10 -O carserv.zip "https://www.free-css.com/assets/files/free-css-templates/download/page291/carserv.zip" && \
    unzip carserv.zip && \
    cp -rvf car-repair-html-template/* . && \
    rm -rf car-repair-html-template carserv.zip

# Start Apache in the foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80


