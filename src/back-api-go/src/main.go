package main

import (
	"encoding/json"
	"fmt"
	"math/rand"
	"net/http"
	"time"

	"github.com/gorilla/mux"
	"github.com/rs/cors"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
)

type contactStruct struct {
	name      string
	birthdate string
	genre     string
	createdAt time.Time
}

var client mongo.Client
var contacts *mgo.Collection

func responseError(w http.ResponseWriter, message string, code int) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)
	json.NewEncoder(w).Encode(map[string]string{"error": message})
}

func responseJSON(w http.ResponseWriter, data interface{}) {
	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(data)
}

func contactCreate(w http.ResponseWriter, r *http.Request) {
	fmt.Println("/contact")
	if err := r.ParseForm(); err != nil {
		fmt.Fprintf(w, "ParseForm() err: %v", err)
		return
	}

	contactsCollection := client.Database("foolishness").Collection("contacts")

	contact := contactStruct{ r.FormValue("name"), r.FormValue("birthdate"), r.FormValue("genre"), time.Now().UTC()}

	insertResult, err := collection.InsertOne(context.TODO(), contact)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Inserted a single document: ", insertResult.InsertedID, contact.name, contact.birthdate, contact.genre)

	responseJSON(w, `{"status":"ok"}`)
}

func status(w http.ResponseWriter, r *http.Request) {
	fmt.Println("/")
	responseJSON(w, `{"message":"hello world from go"}`)
}

func connectToMongo() bool {
	// Set client options
	clientOptions := options.Client().ApplyURI("mongodb://mongodb:27017")

	// Connect to MongoDB
	client, err := mongo.Connect(context.TODO(), clientOptions)

	if err != nil {
		log.Fatal(err)
	}

	// Check the connection
	err = client.Ping(context.TODO(), nil)

	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Connected to MongoDB!")
	return true
}

func main() {
	// Random seed
	rand.Seed(time.Now().UnixNano())

	// Mongo connection
	connectToMongo()

	// Set up routes
	r := mux.NewRouter()
	r.HandleFunc("/contact", contactCreate).Methods("POST")
	r.HandleFunc("/", status).Methods("GET")

	http.ListenAndServe(":80", cors.AllowAll().Handler(r))
	fmt.Println("Back-Api-Go listening on port 80!")
}
