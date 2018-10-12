#!/bin/bash 
source $(pwd)/startup/.dev_envrc


nomad agent -dev -data-dir=/tmp/nomad  &> /tmp/nomad.log &
consul agent -dev &> /tmp/consul.log &

