#!/bin/bash

mkdir -p initramfs
cd initramfs
mkdir -p {bin,dev,sbin,etc,proc,sys/kernel/debug,usr/{bin,sbin},lib,lib64,mnt/root,root}
cp -r ../build/busybox-1.35.0/_install/* .
sudo cp -av /dev/{null,console,tty,sda1} dev/

cat <<EOF > init
#!/bin/sh
 
mount -t proc none /proc
mount -t sysfs none /sys
mount -t debugfs none /sys/kernel/debug
 
exec /bin/sh
EOF

chmod +x init
find . | cpio -H newc -o > ../initramfs.cpio
cd ..
cat initramfs.cpio | gzip > initramfs.igz