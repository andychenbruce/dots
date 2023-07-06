#!/bin/sh

qemu-system-x86_64 \
	-enable-kvm \
	-m 8G \
	-smp 8 \
	-bios /gnu/store/im3j574czs0vh6369qfzaiazgp2vs43j-ovmf-20170116-1.13a50a6/share/firmware/ovmf_x64.bin \
	-drive file=poop.qcow2,index=0,media=disk,if=virtio \
	-boot d \
	-nic user,model=virtio-net-pci,hostfwd=tcp::8888-:22 \
	-serial mon:stdio \
	-nographic
