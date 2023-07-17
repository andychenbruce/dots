#!/bin/sh

qemu-system-x86_64 \
	-nodefaults \
	-machine vmport=off \
	-enable-kvm \
	-m 4G \
	-smp 8 \
	-bios /gnu/store/im3j574czs0vh6369qfzaiazgp2vs43j-ovmf-20170116-1.13a50a6/share/firmware/ovmf_x64.bin \
	-vga qxl \
	-audiodev pa,id=snd0 \
	-device ich9-intel-hda \
	-device hda-output,audiodev=snd0 \
	-nic user,model=virtio-net-pci,hostfwd=tcp::5555-:5555,smb=/home/pooman123/andy_vm/windows/poop_smb,smbserver=10.0.2.4\
	-spice disable-ticketing=on,unix=on,addr=poo.sock \
	-drive file=disk.qcow2,index=0,media=disk,if=virtio \
	-device virtio-serial \
	-chardev spicevmc,id=spicechannel0,name=vdagent \
	-device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
	-rtc base=localtime,clock=host \
	#-usb -device usb-tablet \
	#-drive file=/mnt/poo/stuff/isos/Win8.1_English_x64.iso,media=cdrom \
	#-drive file=/mnt/poo/stuff/isos/virtio-win-0.1.204.iso,media=cdrom
