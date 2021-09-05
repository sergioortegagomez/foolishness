#!/bin/bash 

cd "$(dirname $0)/.."

# Reset
NoColor='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

function usage() {
    echo -e ""
    echo -e "${Green}Usage: ${NoColor}"
    echo -e "  bin/devcontrol.sh ${Yellow}[command]${NoColor}"
    echo -e ""
    echo -e "${Green}Available Commands:${NoColor}"
    echo -e "  - ${Cyan}up${NoColor}                 docker-compose env up"
    echo -e "  - ${Cyan}down${NoColor}               docker-compose env down"
    # echo -e "  - ${Cyan}build${NoColor}            build all docker images"
    echo -e "  - ${Cyan}test${NoColor}               launch your cucumber/gatling test"
    echo -e "  - ${Cyan}status${NoColor}             show status info"
    # echo -e "  - ${Cyan}docker push${NoColor}      push your docker images"
    echo -e "  - ${Cyan}kubernetes up${NoColor}      kubernetes env up"
    echo -e "  - ${Cyan}kubernetes down${NoColor}    kubernetes env down"
    echo -e ""
}

function build() {
    for d in back-api-go back-api-node back-api-java web; do
        echo -e ""
        echo -e "${Green}[ ${Yellow}${d}${Green} ]-------------------------------------------------------${NoColor}"
        src/${d}/build.sh
    done
}

function up() {
    docker-compose -f docker-compose.databases.yml -f docker-compose.tools.yml up -d --remove-orphans
    build
    docker-compose up -d
    echo -e "\n${Green}-------------------------------------------------------------${NoColor}"
    status
}

function down() {
    docker-compose -f docker-compose.databases.yml -f docker-compose.tools.yml -f docker-compose.yml down
}

function status() {
    echo -e "\n${Green}[ ${Yellow}App Services ${Green}]${NoColor}"
    docker-compose ps
    echo -e "\n${Green}[ ${Yellow}Databases Services ${Green}]${NoColor}"
    docker-compose -f docker-compose.databases.yml ps
    echo -e "\n${Green}[ ${Yellow}Tools Services ${Green}]${NoColor}"
    docker-compose -f docker-compose.tools.yml ps  
}

function test() {
    docker-compose -f docker-compose.test.yml up $2    
}

function logs() {
    docker-compose logs -f
}

function execDocker() {
    case $2 in
        push)
            docker-compose -f docker-compose.tools.yml up -d registry --remove-orphans
            for image in web front-api-node back-api-node back-api-go back-api-java; do
                docker push localhost:5000/foolishness/$image:latest
            done
        ;;
        *)
            echo -e ""
            echo -e "Usage: "
            echo -e "  bin/devcontrol.sh docker [push]"
            echo -e ""
        ;;
    esac
}

function execKubernetes() {
    [ ! -f "/home/vagrant/.kube/config" ] && sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@192.168.50.10:/home/vagrant/.kube/config /home/vagrant/.kube/config
    cd kubernetes

    case $2 in
        up)
            kubectl apply -f namespace.yaml
            kubectl apply -f mongodb-service.yaml
            for app in back-api-go back-api-java back-api-node front-api-node web; do
                kubectl apply -f $app-service.yaml
                kubectl apply -f $app-deployment.yaml
            done
        ;;
        down)
            kubectl delete -f namespace.yaml
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
    up) up ;;
    down) down ;;
    build) build ;;
    test) test $@ ;;
    status) status ;;
    logs) logs ;;
    docker) execDocker $@ ;;
    kubernetes) execKubernetes $@ ;;
    *) usage ;;
esac
