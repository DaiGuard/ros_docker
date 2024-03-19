# ros_docker

Docker environment for ROS1(kinetic, melodic, noetic),ROS2(foxy, galactic, humble)

```bash
# build docker image
$ ./docker/build_image.sh -d <branch name>
# run container
$ ./docker/run_container.sh -d <branch name>
# attach container
$ ./docker/attach_container.sh -d <branch name>
```

## ToDo

[ ] enable gpus options
[ ] refactoring the code