package main

import (
	"database/sql"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)

// Define a structure to represent a user.
type User struct {
	ID       int    `json:"id"`
	Username string `json:"username"`
	Password string `json:"password"`
}

// Define a structure to represent a booking.
type Booking struct {
	ID             int    `json:"id"`
	Name           string `json:"name"`
	PhoneNumber    string `json:"phoneNumber"`
	PickupLocation string `json:"pickupLocation"`
	Destination    string `json:"destination"`
	VehicleType    string `json:"vehicleType"`
}

func main() {
	// Initialize a database connection.
	db, err := sql.Open("mysql", "your_user:your_password@tcp(localhost:3306)/myappdb")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Initialize the Gin router.
	r := gin.Default()

	// API endpoints for user registration and login.
	r.POST("/register", func(c *gin.Context) {
		var user User
		if err := c.ShouldBindJSON(&user); err == nil {
			// Insert the user into the database.
			_, err := db.Exec("INSERT INTO users (username, password) VALUES (?, ?)", user.Username, user.Password)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to register user", "err": err})
				return
			}
			c.JSON(http.StatusOK, gin.H{"message": "User registered successfully"})
		} else {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}
	})

	r.POST("/login", func(c *gin.Context) {
		var user User
		if err := c.ShouldBindJSON(&user); err == nil {
			// Check the user's credentials in the database.
			row := db.QueryRow("SELECT id FROM users WHERE username = ? AND password = ?", user.Username, user.Password)
			err := row.Scan(&user.ID)
			if err != nil {
				c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid username or password"})
				return
			}
			c.JSON(http.StatusOK, user)
		} else {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}
	})

	// API endpoint for booking a cab.
	r.POST("/book-cab", func(c *gin.Context) {
		var booking Booking
		if err := c.ShouldBindJSON(&booking); err == nil {
			// Insert the booking into the database.
			_, err := db.Exec("INSERT INTO bookings (name, phoneNumber, pickupLocation, destination, vehicleType) VALUES (?, ?, ?, ?, ?)", booking.Name, booking.PhoneNumber, booking.PickupLocation, booking.Destination, booking.VehicleType)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to book a cab"})
				return
			}
			c.JSON(http.StatusOK, gin.H{"message": "Cab booked successfully"})
		} else {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}
	})

	// Start the API server.
	if err := r.Run(":8080"); err != nil {
		log.Fatal(err)
	}
}
