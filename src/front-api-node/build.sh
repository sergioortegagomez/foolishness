#!/bin/bash

cd "$(dirname $0)"

docker build --tag docker-registry.local/foolishness/front-api-node:latest .