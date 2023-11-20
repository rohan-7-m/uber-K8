#!/bin/sh
echo "db test the Go application..."
# Wait for MariaDB to be ready before starting the application
wait-for "$DB_HOST:$DB_PORT" -- echo "Database is up"

# Set environment variables
export PATH="$PATH:$(go env GOPATH)/bin"
# Other environment variable configurations if needed...
echo "start the Go application..."
# Run the Go application
sh "ls"
/app/myapp
echo "end the Go application..."