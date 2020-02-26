#!/bin/bash 

function usage() {
    echo -e "usage: bin/devcontrol.sh [start|destroy|build|test|status|docker push]"
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
    docker-compose -f docker-compose.test.yml rm --stop --force gatling-runner-main cucumber-runner-main
    docker-compose down
}

function status() {
    docker-compose ps
    docker-compose -f docker-compose.test.yml ps    
}

function test() {
    docker system prune -f > /dev/null
    docker-compose -f docker-compose.test.yml up $2    
}

function logs() {
    docker-compose logs -f
}

function execDocker() {
    case $2 in
        push)
            for image in web front-api-node back-api-php back-api-go back-api-java; do
                docker push docker-registry.local/foolishness/$image:latest
            done
        ;;
    esac
}

case $1 in
    start) start ;;
    destroy) destroy ;;
    build) build ;;
    test) test $@ ;;
    status) status ;;
    logs) logs ;;
    docker) execDocker $@ ;;
    *) usage ;;
esac
