package main

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"math/rand"
	"net/http"
	"os"
	"time"

	"github.com/gorilla/mux"
	"github.com/rs/cors"
	"gopkg.in/mgo.v2"
)

type voteStruct struct {
	Vote      string
	CreatedAt time.Time
}

var votes *mgo.Collection

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

func voteCreate(w http.ResponseWriter, r *http.Request) {
	log.Println("/votecreate")
	b, err := ioutil.ReadAll(r.Body)
	defer r.Body.Close()
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}

	vote := &voteStruct{}
	vote.Vote = string(b[5:])
	vote.CreatedAt = time.Now().UTC()

	if err := votes.Insert(vote); err != nil {
		responseError(w, err.Error(), http.StatusInternalServerError)
		log.Println("Vote not created!!")
		return
	}

	log.Println("Vote", vote.Vote, "has been created")

	responseJSON(w, vote)
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
	votes = session.DB("foolishness").C("votes")

	// Set up routes
	r := mux.NewRouter()
	r.HandleFunc("/votecreate", voteCreate).Methods("POST")
	r.HandleFunc("/", status).Methods("GET")

	http.ListenAndServe(":80", cors.AllowAll().Handler(r))
	log.Println("Back-Api-Go listening on port 80!")
}
