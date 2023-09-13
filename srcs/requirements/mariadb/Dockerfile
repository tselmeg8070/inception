# Use a base image that doesn't rely on Docker Hub, e.g., Debian Buster
FROM debian:buster

# Install MariaDB
RUN     apt-get update -y && \
        apt-get upgrade -y && \
        apt-get install mariadb-server \
        mariadb-client -y

RUN     mkdir -p /var/run/mysqld && \
        chown -R mysql:mysql /var/run/mysqld && \
        chmod 777 /var/run/mysqld && \
        chown -R mysql:mysql /etc/mysql/

# Copy custom configuration file and setup SQL script
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./conf/exported.sql /tmp/exported.sql
COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh && \
    chown -R mysql:mysql /tmp/ && \
    chown -R mysql:mysql /etc/mysql

# Start MariaDB and run the setup SQL script during container startup
ENTRYPOINT ["sh", "/tmp/script.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]