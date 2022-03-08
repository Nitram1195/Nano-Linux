#!/bin/bash

BUSYBOX_VERSION=1.35.0
BUILD_DIR=build

mkdir -p $BUILD_DIR

echo "Downloading Busybox $BUSYBOX_VERSION ..."
wget https://www.busybox.net/downloads/busybox-$BUSYBOX_VERSION.tar.bz2
tar -xf busybox-$BUSYBOX_VERSION.tar.bz2 -C build
cd build/busybox-$BUSYBOX_VERSION

make defconfig
patch -s -p0 < ../../busybox.patch
make -j4
make install

rm ../../busybox-$BUSYBOX_VERSION.tar.bz2
