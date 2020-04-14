#!/bin/bash 

cd "$(dirname $0)/.."

function usage() {
    echo -e "usage: bin/platformcontrol.sh [up|destroy|ssh|status|halt]"
}

case $1 in
    up) vagrant up ;;
    destroy) vagrant destroy -f ;;
    ssh) vagrant ssh foolishness-dev ;;
    status) vagrant status ;;
    halt) vagrant halt ;;
    *) usage ;;
esac
