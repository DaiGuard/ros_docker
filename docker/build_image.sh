#! /bin/bash

cd $(dirname $0)


help()
{
    echo "usage: build_image.sh [-d | --distro <distro name>]"    
    echo " "
    echo "-d, --distro  <distroname>: melodic, foxy"
    echo "--with-cuda: add cuda library"
    exit 2
}


SHORT=d:,h
LONG=distro:,with-cuda,help
OPTS=$(getopt -a -n build_image.sh --options $SHORT --longoptions $LONG -- "$@")

VALID_ARGUMENTS=$#

distro=melodic
use_cuda=false

if [ "$VALID_ARGUMENTS" -eq 0 ]; then
    help
fi

eval set -- "$OPTS"

while :
do
    case "$1" in
        -d | --distro )
            distro="$2"
            shift 2
            ;;
        --with-cuda )
            use_cuda=true
            shift;
            ;;
        -h | --help)
            help
            exit 0
            ;;
        --)
            shift;
            break
            ;;
        *)
            echo "Unexpected option: $1"
            help
            ;;
    esac
done


if "${use_cuda}"; then
    docker build \
        -t $USER/ros:$distro-cuda \
        --build-arg user=$USER \
        --build-arg uid=$(id -u $USER) \
        --build-arg gid=$(id -g $USER) \
        -f Dockerfile.${distro}-cuda \
        .
else
    docker build \
        -t $USER/ros:$distro \
        --build-arg user=$USER \
        --build-arg uid=$(id -u $USER) \
        --build-arg gid=$(id -g $USER) \
        -f Dockerfile.${distro} \
        .
fi
