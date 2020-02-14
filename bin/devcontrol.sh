#!/bin/bash

function usage() {
    echo -e "usage: bin/devcontrol.sh [start|destroy|build|test|status]"
}

function build() {
    docker-compose build
}

function start() {
    docker-compose up -d --remove-orphans    
    docker-compose logs -f
}

function destroy() {
    docker-compose -f docker-compose.gatling.yml down --remove-orphans    
    docker-compose down
}

function status() {
    docker-compose ps
    docker-compose -f docker-compose.gatling.yml ps    
}

function test() {
    docker-compose -f docker-compose.gatling.yml up gatling-runner-main
}

case $1 in
    start) 
        start
    ;;
    destroy)
        destroy
    ;;
    build)
        build
    ;;
    test)
        test
    ;;
    status)
        status
    ;;
    *)
        usage
    ;;
esac
