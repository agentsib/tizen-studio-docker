#!/bin/bash
set -eu

cd $(dirname "$0")

echo "Update X authorization..."

KEY=$(xauth list  |grep $(hostname) | awk '{ print $3 }' | head -n 1)
xauth add tizen-stub/unix:0 . $KEY

echo "Updating KVM group id..."

KVM_ID=$(getent group | grep kvm: | cut -d : -f 3)
LIBVIRT_ID=$(getent group | grep libvirt: | cut -d : -f 3)

docker start tizen-stub
docker exec tizen-stub sudo groupmod -g $KVM_ID kvm
docker exec tizen-stub sudo groupmod -g $LIBVIRT_ID libvirtd

if [ -f $PWD/_data/tizen-studio/.gitkeep ]; then
    rm $PWD/_data/tizen-studio/.gitkeep
    rm $PWD/_data/workspace/.gitkeep
    rm $PWD/_data/package-manager/.gitkeep
    rm $PWD/_data/tizen-studio-data/.gitkeep
    docker exec tizen-stub ./web-cli_Tizen_Studio_2.4_ubuntu-64.bin --accept-license /home/tizen/tizen-studio
    docker exec tizen-stub mv -f .sdk.info tizen-studio/sdk.info
    docker exec tizen-stub rm -rf tizen-studio-data.1
fi
docker stop tizen-stub

echo "KVM update done!"

if [ ! -f $PWD/_data/tizen-studio/ide/TizenStudio.sh ]; then
    docker start tizen-stub
    docker exec -it tizen-stub tizen-studio/package-manager/package-manager.bin
    docker stop tizen-stub
else
  docker start tizen-stub
  docker attach tizen-stub
fi
