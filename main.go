package main

import (
	"fmt"
	"html/template"
	"net/http"
	"os"
)

type info struct {
	Hostname string
	Message  string
	Headers  http.Header
}

func indexHandler(response http.ResponseWriter, request *http.Request) {
	tmplt := template.New("index.html")
	tmplt, _ = tmplt.ParseFiles("index.html")

	hostname, _ := os.Hostname()
	message := "Hello World"

	if os.Getenv("message") != "" {
		message = os.Getenv("message")
	}

	p := info{
		Hostname: hostname,
		Message:  message,
		Headers:  request.Header,
	}

	tmplt.Execute(response, p)
}

func simpleHelloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello %s!", r.URL.Path[1:])
}

func main() {
	fmt.Println("Server Starting")
	http.HandleFunc("/hello", simpleHelloHandler)
	http.HandleFunc("/", indexHandler)

	http.ListenAndServe(":8080", nil)
}
