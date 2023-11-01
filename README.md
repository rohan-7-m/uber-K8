# uber-K8
project to learn k8 and implement in uber 


# SETUP minikube, mysql and golang server in local.

project to learn k8 and implement in uber

Minikube setup in M1:

Step 1: Install Qemu

Install the Qemu emulator using the following command.

brew install qemu
Step 2: Setup Qemu socket_vvmnet

For minikube service URLs to work, you need to start the socket_vmnet service

brew install socket_vmnet
brew tap homebrew/services
HOMEBREW=$(which brew) && sudo ${HOMEBREW} services start socket_vmnet
Step 3: Install minikube

brew install minikube
Step 4: Start Minikube with the Qemu driver and socket_vmnet

minikube start --driver qemu --network socket_vmnet

minikube start --cpus 2 --memory 4096

---

Mysql:

brew install mysql

brew services start mysql

mysql -u root -p

brew services start mysql:
This command is used to start the MySQL service managed by Homebrew. It does not log you into the MySQL server directly.
It starts the MySQL server in the background, and you don't need to provide the MySQL root user's password.
It is typically used to start the MySQL server as a background service, making it available for applications to connect to the MySQL database.
mysql -u root -p:
This command is used to log in to the MySQL server as the root user. It does not start the MySQL service if it's not already running; it's simply for connecting to an already running MySQL server.
It prompts you to enter the MySQL root user's password after you execute the command.
It provides direct access to the MySQL command-line client, where you can execute SQL queries, manage databases, and perform various MySQL-related tasks.

CREATE USER 'username'@'hostname' IDENTIFIED BY 'password'; #create user

---

Golang :

#run in local
go run .

#run using docker image in local
docker build -t uber .  
docker run -p 8080:8080 uber


---

# create 2 Docker containers backend go server and mySql db . And establish communication between them.



To run MySQL and your Golang server in separate Docker containers and have them communicate with each other. This is a more common and recommended approach for containerized applications, as it allows for better isolation and scalability. You can use Docker Compose to manage both containers in a multi-container environment.

Here's a basic outline of how to set up your MySQL and Golang containers in separate containers and have them communicate:

1. **Create a Docker Compose File**:
   Create a `docker-compose.yml` file in your project directory. This file will define the services (containers) and their configurations. Here's an example:

   ```yaml
   version: '3'

   services:
     mysql:
       image: mysql:latest
       environment:
         MYSQL_ROOT_PASSWORD: your-root-password
         MYSQL_DATABASE: your-database-name

     golang-app:
       build:
         context: .
       ports:
         - "8080:8080"
       depends_on:
         - mysql
   ```

   Replace `your-root-password` and `your-database-name` with your desired MySQL root password and database name.

2. **Update Your Golang Code**:
   Make sure your Golang application is configured to connect to the MySQL database using the hostname `mysql`, which corresponds to the service name you defined in the Docker Compose file. For example:

   ```go
   dataSourceName := "username:password@tcp(mysql:3306)/your-database-name"
   db, err := sql.Open("mysql", dataSourceName)
   ```

   The `mysql` hostname is used to resolve the IP address of the MySQL container in the same Docker Compose network.

3. **Build and Run the Docker Containers**:
   Run the following command to build and start both the MySQL and Golang containers:

   ```bash
   docker-compose up
   ```

   This command will start both containers and configure them to communicate with each other. The MySQL container is accessible as `mysql` from the Golang container.

Now, your Golang server and MySQL server run in separate containers, but they can communicate through the Docker Compose network. The Golang server can connect to the MySQL database using the service name `mysql`. This setup provides better isolation and flexibility for scaling and managing your application components.




