# Tizen Studio on Docker

Based on https://github.com/cirocavani/tizen-studio-docker

## Setup

Assumes:

* KVM and Libvirt installed in the Host to enable Emulator hardware acceleration
* X running in the Host, same user of Docker Container (1000)

## Setup

Assumes:

* KVM and Libvirt installed in the Host to enable Emulator hardware acceleration
* X running in the Host, same user of Docker Container (1000)

```sh
./01_build_image.sh
./02_create_container.sh
./03_configure.sh

docker start tizen-studio
docker attach tizen-studio
# Press ENTER to see the prompt
```

**Starting IDE**

First time you need install pligins:

```sh
tizen-studio/package-manager/package-manager.bin
```

Runing from inside the container, IDE window opens in the Host X Display.

```sh
TizenStudio.sh > ~/ide.log 2>&1 &
```

## Data

All data stored in `_data` dir. You can recreate container and data will be safe.
