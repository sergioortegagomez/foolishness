package main

import (
	"log"
	"net/http"
)

type server struct{}

func (s *server) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "application/json")
	w.Write([]byte(`{"message":"hello world"}`))
	println("/")
}

func main() {
	s := &server{}
	http.Handle("/", s)
	println("Back-Api-Go listening on port 3000!")
	log.Fatal(http.ListenAndServe(":3000", nil))
}
