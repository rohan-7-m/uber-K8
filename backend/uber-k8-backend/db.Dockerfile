# start with base image
# FROM mysql:8.0.23
# FROM arm64v8/mysql:oracle
# import data into container
# All scripts in docker-entrypoint-initdb.d/ are automatically executed during container startup



# Use the official MariaDB image as the base image
FROM mariadb:latest

# Set environment variables (optional)
# ENV MYSQL_ROOT_PASSWORD=rootpassword
# ENV MYSQL_DATABASE=mydatabase
# ENV MYSQL_USER=myuser
# ENV MYSQL_PASSWORD=mypassword
FROM mariadb

# Expose the MySQL port (optional, as it's already exposed in the base image)
EXPOSE 3306


COPY ./database/*.sql /docker-entrypoint-initdb.d/




