



# FROM golang:1.20
# WORKDIR /app

# # add some necessary packages
# # RUN apk update && \
# #     apk add libc-dev && \
# #     apk add gcc && \
# #     apk add make

# # prevent the re-installation of vendors at every change in the source code
# # COPY ./go.mod go.sum ./


# COPY main.go go.mod go.sum ./

# EXPOSE 8080

# # Install Compile Daemon for go. We'll use it to watch changes in go files

# RUN go get github.com/gin-gonic/gin 
# # RUN go mod tidy 
# RUN go get github.com/go-sql-driver/mysql
# RUN go mod download && go mod verify

# # Copy and build the app\
# COPY . .
# COPY ./entrypoint.sh /entrypoint.sh

# # wait-for-it requires bash, which alpine doesn't ship with by default. Use wait-for instead
# ADD https://raw.githubusercontent.com/eficode/wait-for/v2.1.0/wait-for /usr/local/bin/wait-for
# RUN chmod +rx /usr/local/bin/wait-for /entrypoint.sh

# ENTRYPOINT [ "sh", "/entrypoint.sh" ]



# # Use a minimal base image for your Go application
# FROM golang:alpine

# # Set the working directory inside the container
# WORKDIR /app

# # Copy the pre-built binary and entrypoint script into the container
# COPY myapp /myapp
# # COPY entrypoint.sh .

# # Expose the necessary port (if your app listens on a specific port)
# EXPOSE 8080

# ADD https://raw.githubusercontent.com/eficode/wait-for/v2.1.0/wait-for /usr/local/bin/wait-for

# # Set execute permissions for the entrypoint script
# COPY ./entrypoint.sh /entrypoint.sh
# RUN chmod +rx /usr/local/bin/wait-for /entrypoint.sh /myapp

# # Define the entry point for the container
# ENTRYPOINT [ "sh", "/entrypoint.sh" ]



# Use a minimal base image for your Go application
FROM golang:alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the pre-built binary into the container
COPY myapp /app/myapp

# Set execute permissions for the binary
RUN chmod +x /app/myapp

# Add wait-for script
ADD https://raw.githubusercontent.com/eficode/wait-for/v2.1.0/wait-for /usr/local/bin/wait-for
RUN chmod +x /usr/local/bin/wait-for

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Set execute permissions for the entrypoint script
RUN chmod +x /entrypoint.sh

# Expose the necessary port (if your app listens on a specific port)
EXPOSE 8080

# Define the entry point for the container
ENTRYPOINT ["/entrypoint.sh"]
