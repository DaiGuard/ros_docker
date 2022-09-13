#! /bin/bash

help()
{
    echo "usage: run_container.sh [-d | --distro <distro name>]"    
    echo " "
    echo "-d, --distro  <distroname>: melodic, foxy"
    exit 2
}


SHORT=d:,h
LONG=distro:,help
OPTS=$(getopt -a -n run_container.sh --options $SHORT --longoptions $LONG -- "$@")

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

# docker run -it --rm --gpus all \
docker run -it -d --gpus all \
    --restart unless-stopped \
    --network host \
    --privileged \
    --name $USER-ros-$distro \
    --user=$(id -u $USER):$(id -g $USER) \
    --env="DISPLAY" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$HOME/.ssh:/home/$USER/.ssh" \
    --volume="$(pwd)/workspace/$distro:$HOME/workspace" \
    $USER/ros:$distro \
    /bin/bash --login