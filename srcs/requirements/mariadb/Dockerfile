# Base system seletion
FROM debian:bookworm

# commands execution
# -y: input y on y/n
# -p: allow duplicate folder creation
# chown => Change owner
# -R: Recursive => including all subfolders and files
# chown -R user:group object
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

# File copy
# COPY A to B
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/setup.sh /usr/local/bin/

# execution permission to all
RUN chmod +x /usr/local/bin/setup.sh

# Port oepn (MariaDB uses 3306)
EXPOSE 3306

# Entry point (The first program to run)
CMD ["/usr/local/bin/setup.sh"]
