#!/bin/bash

mkdir -p initramfs
cd initramfs
mkdir -p {bin,dev,sbin,etc,proc,sys/kernel/debug,usr/{bin,sbin},lib,mnt/root,root}
cp -r ../build/busybox-1.35.0/_install/* .
cp -r ~/x-tools/x86_64-unknown-linux-gnu/x86_64-unknown-linux-gnu/sysroot/* .

ln -s lib lib64
cp ../main bin
cp ../main-static bin

cat <<EOF > init
#!/bin/sh
 
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs devtmpfs /dev
mount -t debugfs none /sys/kernel/debug
 
exec /bin/sh
EOF

chmod +x init
find . | cpio -H newc -o > ../initramfs.cpio
cd ..
cat initramfs.cpio | gzip > initramfs.igz