#!/bin/bash

cd "$(dirname $0)"

docker build --tag localhost:5000/foolishness/back-api-go:latest .