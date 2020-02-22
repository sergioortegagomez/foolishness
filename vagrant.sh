#!/bin/bash

function printTitle() {
    echo "-[ $1 ]-"
}

# Docker Install
function dockerInstall() {
    printTitle "Docker Install"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get -y install apt-transport-https ca-certificates vim curl gnupg2 software-properties-common docker-ce docker-ce-cli containerd.io docker-compose
    sudo usermod -aG docker vagrant
    cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
    mkdir -p /etc/systemd/system/docker.service.d
    systemctl daemon-reload
    systemctl restart docker
}

# Kube* Install
function kubeInstall() {
    printTitle "Kube Install"
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    sudo add-apt-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"
    sudo apt-get update
    sudo apt-get -y install kubectl
    sudo apt-mark hold kubectl    
}

# main
function main() {
    dockerInstall
    kubeInstall
}

main