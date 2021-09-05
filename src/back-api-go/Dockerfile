FROM golang:alpine AS builder

RUN apk update && apk add --no-cache git

WORKDIR $GOPATH/src/app/
COPY src .

ENV GO111MODULE=off
RUN go get -d -v
RUN go build -o /go/bin/app 

FROM alpine
COPY --from=builder /go/bin/app /app
EXPOSE 80
ENTRYPOINT [ "/app" ]
