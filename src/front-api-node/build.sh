#!/bin/bash

cd "$(dirname $0)"

docker build --tag foolishness/front-api-node:latest .