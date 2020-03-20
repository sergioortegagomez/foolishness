#!/bin/bash

function printTitle() {
    echo "-[ $1 ]-"
}

# Docker Install
function dockerInstall() {
    printTitle "Docker Install"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get upgrade
    apt-get -y install apt-transport-https ca-certificates vim curl gnupg2 software-properties-common docker-ce docker-ce-cli containerd.io docker-compose sshpass
    usermod -aG docker vagrant
    cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "insecure-registries" : ["docker-registry.local"]
}
EOF
    mkdir -p /etc/systemd/system/docker.service.d
    systemctl daemon-reload
    systemctl restart docker
}

# kubectl Install
function kubeInstall() {
    printTitle "kubectl Install"
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    add-apt-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"
    apt-get update
    apt-get -y install kubectl
    apt-mark hold kubectl
    mkdir -p /home/vagrant/.kube
    chown vagrant:vagrant /home/vagrant/.kube
}

# Kompose install
# @url https://github.com/kubernetes/kompose/blob/master/docs/installation.md#github-release
function komposeInstall() {
    printTitle "kompose Install"
    curl -L https://github.com/kubernetes/kompose/releases/download/v1.21.0/kompose-linux-amd64 -o kompose
    chmod +x kompose
    mv kompose /usr/local/bin/kompose
}

# main
function main() {
    dockerInstall
    kubeInstall
    komposeInstall
}

main

printTitle "Finished!"
echo -e
echo -e "Update your /etc/hosts local file with: $(ip addr show eth1 | grep inet | grep eth1 | awk '{print $2}' | cut -d '/' -f1) web"
echo -e