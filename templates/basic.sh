#!/bin/bash

curl -sSL "https://releases.hashicorp.com/nomad/0.8.5/nomad_0.8.5_linux_amd64.zip" -o /tmp/nomad.zip
curl -sSL "https://releases.hashicorp.com/consul/1.2.3/consul_1.2.3_linux_amd64.zip" -o /tmp/consul.zip
unzip /tmp/nomad.zip -d /tmp
install /tmp/nomad /usr/local/bin/nomad
unzip /tmp/consul.zip -d /tmp
install /tmp/consul /usr/local/bin/consul
nomad -autocomplete-install
curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
apt-get update -y
apt-get install -y docker-ce
mkdir -p /etc/nomad.d/data
chmod 775 /etc/nomad.d
mkdir -p /etc/consul.d/data
chmod 775 /etc/consul.d

