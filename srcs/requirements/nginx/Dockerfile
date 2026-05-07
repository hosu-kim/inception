# Base system selection
FROM debian:bookworm

# RUN: Commands execution
# openssl: installed for SSL/TLS
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    mkdir -p /etc/nginx/ssl

# File copy
# COPY A to B
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/setup.sh /usr/local/bin/

# execution permission to all
RUN chmod +x /usr/local/bin/setup.sh

# Port open (nginx uses 443 port)
EXPOSE 443

# Entry point (The first program to run)
CMD ["/usr/local/bin/setup.sh"]
