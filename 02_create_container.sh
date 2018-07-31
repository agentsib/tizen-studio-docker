#!/bin/bash
set -eu

cd $(dirname "$0")

if [ ! -z "$(docker ps -q -a -f name=tizen-stub$)" ]; then
    docker rm -f tizen-stub
fi

#--net host \

docker create \
    -it \
    --net host \
    --privileged \
    --device /dev/snd \
    --name tizen-stub \
    --hostname tizen-stub \
    --env DISPLAY=$DISPLAY \
    -e XAUTHORITY=/tmp/.Xauthority  \
    -v $HOME/.Xauthority:/tmp/.Xauthority \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume $PWD/_data/tizen-studio-data:/home/tizen/tizen-studio-data \
    --volume $PWD/_data/tizen-studio:/home/tizen/tizen-studio \
    --volume $PWD/_data/workspace:/home/tizen/workspace \
    --volume $PWD/_data/package-manager:/home/tizen/.package-manager \
    tizen/stub:latest

echo "Done!"
