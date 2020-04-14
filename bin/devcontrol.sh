#!/bin/bash 

cd "$(dirname $0)/.."

function usage() {
    echo -e ""
    echo -e "Usage: "
    echo -e "  bin/devcontrol.sh [command]"
    echo -e ""
    echo -e "Available Commands:"
    echo -e "  - start       dev env up"
    echo -e "  - destroy     dev env down"
    echo -e "  - build       build all docker images"
    echo -e "  - test        launch your cucumber/gatling test"
    echo -e "  - status      show status info"
    echo -e "  - docker push push your docker images"
    echo -e "  - kubernetes  launch to kubernetes cluster"
    echo -e ""
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
    docker-compose -f docker-compose.test.yml rm -f gatling-runner-main cucumber-runner-main
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

function execKubernetes() {
    [ ! -f "/home/vagrant/.kube/config" ] && sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@192.168.50.10:/home/vagrant/.kube/config /home/vagrant/.kube/config
    cd kubernetes

    case $2 in
        apply)
            kubectl $2 -f namespace.yaml
            kubectl $2 -f mongodb-service.yaml
            for app in back-api-go back-api-java back-api-php front-api-node web; do
                kubectl $2 -f $app-service.yaml
                kubectl $2 -f $app-deployment.yaml
            done
        ;;
        delete)
            kubectl $2 -f namespace.yaml
        ;;
        *)
            echo -e ""
            echo -e "Usage: "
            echo -e "  bin/devcontrol.sh kubernetes [apply|delete]"
            echo -e ""
        ;;
    esac
    cd ..
}

case $1 in
    start) start ;;
    destroy) destroy ;;
    build) build ;;
    test) test $@ ;;
    status) status ;;
    logs) logs ;;
    docker) execDocker $@ ;;
    kubernetes) execKubernetes $@ ;;
    *) usage ;;
esac
