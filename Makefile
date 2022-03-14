all:
	./kernel.sh
	./busybox.sh
	./rootfs.sh

clean:
	rm -rf build
	rm -rf initramfs/*
	rm -f initramfs.cpio initramfs.igz

run:
	./run-qemu.sh