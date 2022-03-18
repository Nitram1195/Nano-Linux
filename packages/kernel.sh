#!/bin/bash

KERN_VERSION=5.15.20
KERN_SUBVERSION=$(echo $KERN_VERSION | cut -d '.' -f 1)
BUILD_DIR=$(dirname "$0")/../build

mkdir -p $BUILD_DIR

if [ ! -d $BUILD_DIR/linux-$KERN_VERSION ]; then
  echo "Downloading kernel $KERN_VERSION ..."
  wget -qO- https://mirrors.edge.kernel.org/pub/linux/kernel/v$KERN_SUBVERSION.x/linux-$KERN_VERSION.tar.xz | tar xJf - -C $BUILD_DIR
fi

cd $BUILD_DIR/linux-$KERN_VERSION
make allnoconfig
#make defconfig

echo "Applying patch ..."
patch -s -p0 < ../../patches/config.patch

echo "Building kernel ..."
make -j8