package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"math/rand"
	"net/http"
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
	fmt.Println("/votecreate")
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
		fmt.Println("Vote not created!!")
		return
	}

	fmt.Println("Vote", vote.Vote, "has been created")

	responseJSON(w, vote)
}

func status(w http.ResponseWriter, r *http.Request) {
	fmt.Println("/")
	responseJSON(w, `{"message":"hello world from go"}`)
}

func connectToMongo() bool {
	ret := false
	fmt.Println("Connecting to mongodb:27017")

	// tried doing this - doesn't work as intended
	defer func() {
		if r := recover(); r != nil {
			fmt.Println("Detected panic")
			var ok bool
			err, ok := r.(error)
			if !ok {
				fmt.Printf("pkg:  %v,  error: %s", r, err)
			}
		}
	}()

	maxWait := time.Duration(5 * time.Second)
	session, sessionErr := mgo.DialWithTimeout("mongodb:27017", maxWait)
	if sessionErr == nil {
		session.SetMode(mgo.Monotonic, true)
		votes = session.DB("foolishness").C("votes")
		if votes != nil {
			fmt.Println("Got a votes collection object")
			ret = true
		}
	} else {
		fmt.Println("Unable to connect to mongodb:27017 instance!")
	}
	return ret
}

func main() {
	// Random seed
	rand.Seed(time.Now().UnixNano())

	// Mongo connection
	if connectToMongo() {
		fmt.Println("Connected")
	} else {
		fmt.Println("Not Connected")
	}

	// Set up routes
	r := mux.NewRouter()
	r.HandleFunc("/votecreate", voteCreate).Methods("POST")
	r.HandleFunc("/", status).Methods("GET")

	http.ListenAndServe(":80", cors.AllowAll().Handler(r))
	fmt.Println("Back-Api-Go listening on port 80!")
}
