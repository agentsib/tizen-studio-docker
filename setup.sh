#!/bin/bash
set -eu

cd $(dirname "$0")

JAVA_JDK=jdk-8u181-linux-x64.tar.gz
JAVA_URL=http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz

if [ ! -f _deps/$JAVA_JDK ]; then
    curl -k -L \
        -H "Cookie: oraclelicense=accept-securebackup-cookie" \
        $JAVA_URL \
        -o _deps/$JAVA_JDK
fi

TIZEN_CLI=web-cli_Tizen_Studio_2.4_ubuntu-64.bin
TIZEN_URL=http://download.tizen.org/sdk/Installer/tizen-studio_2.4/web-cli_Tizen_Studio_2.4_ubuntu-64.bin

if [ ! -f _deps/$TIZEN_CLI ]; then
    curl -k -L \
        $TIZEN_URL \
        -o _deps/$TIZEN_CLI
    chmod +x _deps/$TIZEN_CLI
fi
