#! /bin/bash

# docker run -it --rm --gpus all \
docker run -it -d --gpus all \
    --restart unless-stopped \
    --network host \
    --name ros-foxy \
    --user=$(id -u $USER):$(id -g $USER) \
    --env="DISPLAY" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$HOME/.ssh:/home/$USER/.ssh" \
    $USER/ros:foxy \
    /bin/bash --login