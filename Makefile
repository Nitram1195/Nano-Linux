all:
	./packages/kernel.sh
	./packages/busybox.sh
	./rootfs.sh

clean:
	rm -rf build
	rm -rf initramfs/*
	rm -f initramfs.cpio initramfs.igz

run:
	qemu-system-x86_64 \
	-kernel build/linux-5.15.20/arch/x86/boot/bzImage \
	-initrd initramfs.igz \
	-nographic -append "earlyprintk=serial,ttyS0 console=ttyS0" \
	-m 512M