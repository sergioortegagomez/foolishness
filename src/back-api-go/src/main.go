package main

import (
	"encoding/json"
	"log"
	"math/rand"
	"net/http"
	"os"
	"time"

	"github.com/gorilla/mux"
	"github.com/rs/cors"
	"gopkg.in/mgo.v2"
)

type randomNumberStruct struct {
	Number    int
	CreatedAt time.Time
}

var randomNumbers *mgo.Collection

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

func randomNumberCreate(w http.ResponseWriter, r *http.Request) {
	log.Println("/randomnumbercreate")
	randomNumber := &randomNumberStruct{}
	randomNumber.Number = rand.Intn(999999999)
	randomNumber.CreatedAt = time.Now().UTC()

	if err := randomNumbers.Insert(randomNumber); err != nil {
		responseError(w, err.Error(), http.StatusInternalServerError)
		log.Println("Number not created!!")
		return
	}

	log.Println("Number created ", randomNumber.Number)

	responseJSON(w, randomNumber)
}

func status(w http.ResponseWriter, r *http.Request) {
	log.Println("/")
	responseJSON(w, `{"message":"hello world from go"}`)
}

func main() {
	// Random seed
	rand.Seed(time.Now().UnixNano())

	// Mongo connection
	session, err := mgo.Dial("mongodb:27017")
	if err != nil {
		log.Fatalln(err)
		log.Fatalln("mongodb not connected!!")
		os.Exit(1)
	}
	defer session.Close()
	session.SetMode(mgo.Monotonic, true)
	randomNumbers = session.DB("foolishness").C("randomNumbers")

	// Set up routes
	r := mux.NewRouter()
	r.HandleFunc("/randomnumbercreate", randomNumberCreate).Methods("POST")
	r.HandleFunc("/", status).Methods("GET")

	http.ListenAndServe(":80", cors.AllowAll().Handler(r))
	log.Println("Back-Api-Go listening on port 80!")
}
