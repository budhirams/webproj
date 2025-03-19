FROM ubuntu:22.04
MAINTAINER budhiramsahani421@gmail.com

# Install Apache2, wget, zip, and unzip
RUN apt update && apt install -y apache2 wget zip unzip && rm -rf /var/lib/apt/lists/*
# Set ServerName to suppress the warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

WORKDIR /var/www/html

RUN wget --retry-connrefused --waitretry=5 --timeout=30 -t 10 -O dozecafe.zip "https://www.free-css.com/assets/files/free-css-templates/download/page291/dozecafe.zip" && \
    unzip dozecafe.zip && \
    cp -rvf html/* . && \
    rm -rf html dozecafe.zip

# Start Apache in the foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80


