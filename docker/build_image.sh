#! /bin/bash

cd $(dirname $0)


help()
{
    echo "usage: build_image.sh [-d | --distro <distro name>]"    
    echo " "
    echo "-d, --distro  <distroname>: kinetic, melodic, foxy, noetic"
    exit 2
}


SHORT=d:,h
LONG=distro:,help
OPTS=$(getopt -a -n build_image.sh --options $SHORT --longoptions $LONG -- "$@")

VALID_ARGUMENTS=$#

distro=melodic

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



docker build \
    -t $USER/ros:$distro \
    --build-arg user=$USER \
    --build-arg uid=$(id -u $USER) \
    --build-arg gid=$(id -g $USER) \
    -f Dockerfile.$distro \
    .