#!/bin/bash

BUSYBOX_VERSION=1.35.0
BUILD_DIR=$(dirname "$0")/../build

mkdir -p $BUILD_DIR

if [ ! -d $BUILD_DIR/linux-$KERN_VERSION ]; then
  echo "Downloading Busybox $BUSYBOX_VERSION ..."
  wget https://www.busybox.net/downloads/busybox-$BUSYBOX_VERSION.tar.bz2
  tar -xf busybox-$BUSYBOX_VERSION.tar.bz2 -C $BUILD_DIR
  rm busybox-$BUSYBOX_VERSION.tar.bz2  
fi

cd $BUILD_DIR/busybox-$BUSYBOX_VERSION

make defconfig
patch -s -p0 < ../../patches/busybox.patch
make -j4
make install
