# Use a base image that doesn't rely on Docker Hub, e.g., Debian Buster
FROM debian:buster

# Install MariaDB
RUN apt-get update && apt-get install -y software-properties-common
RUN apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
RUN add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://mirror.rackspace.com/mariadb/repo/10.3/debian buster main'

RUN     apt-get install mariadb-server
RUN     apt-get install mariadb-client

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