#!/bin/bash

cd "$(dirname $0)"

docker build --tag foolishness/back-api-go:latest .