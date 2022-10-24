#! /bin/bash

help()
{
    echo "usage: attach_container.sh [-d | --distro <distro name>]"    
    echo " "
    echo "-d, --distro  <distroname>: melodic, foxy, noetic"
    exit 2
}


SHORT=d:,h
LONG=distro:,help
OPTS=$(getopt -a -n attach_container.sh --options $SHORT --longoptions $LONG -- "$@")

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


docker exec -it $USER-ros-$distro /bin/bash