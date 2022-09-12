#! /bin/bash


cd $(dirname $0)

docker build \
    -t $USER/ros:foxy \
    --build-arg user=$USER \
    --build-arg uid=$(id -u $USER) \
    --build-arg gid=$(id -g $USER) \
    -f Dockerfile \
    .