FROM golang

WORKDIR /opt/go

COPY src /opt/go

ENV GOPATH=/opt/go
RUN go get "gopkg.in/mgo.v2" "github.com/gorilla/mux" "github.com/rs/cors"

EXPOSE 80

RUN go build -o app

CMD ["./app"]