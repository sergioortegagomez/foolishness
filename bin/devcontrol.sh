#!/bin/bash 

function usage() {
    echo -e "usage: bin/devcontrol.sh [start|destroy|build|test|status]"
}

function build() {
    for d in back-api-go back-api-php back-api-java front-api-node web; do
        src/$d/build.sh
    done
}

function start() {
    docker-compose up -d --remove-orphans
}

function destroy() {
    docker-compose -f docker-compose.gatling.yml rm --stop --force gatling-runner-main
    docker-compose down
}

function status() {
    docker-compose ps
    docker-compose -f docker-compose.gatling.yml ps    
}

function test() {
    docker-compose -f docker-compose.gatling.yml up gatling-runner-main
}

function logs() {
    docker-compose logs -f
}

case $1 in
    start) start ;;
    destroy) destroy ;;
    build) build ;;
    test) test ;;
    status) status ;;
    logs) logs ;;
    *) usage ;;
esac
