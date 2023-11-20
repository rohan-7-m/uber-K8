# Use an official Go 1.20 or higher runtime as a parent image
FROM golang:1.20

# Set the working directory inside the container
WORKDIR /app

# Copy the Go source code and Go module files into the container
COPY main.go go.mod go.sum ./


RUN go get github.com/gin-gonic/gin 
# RUN go mod tidy 
RUN go get github.com/go-sql-driver/mysql

RUN go mod download && go mod verify
# # Build the Go application with a custom executable name
RUN go build -o myapp

# # Expose the port the application will run on
EXPOSE 8080

# # Command to run the application
CMD ["./myapp"]



FROM mariadb:latest

ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=mydatabase
ENV MYSQL_USER=myuser
ENV MYSQL_PASSWORD=mypassword

EXPOSE 3306


COPY ./database/*.sql /docker-entrypoint-initdb.d/