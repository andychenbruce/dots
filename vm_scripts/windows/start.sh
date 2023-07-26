#!/bin/sh

GENERIC_OPTIONS=( 
    -nodefaults
    -enable-kvm
    -bios /gnu/store/im3j574czs0vh6369qfzaiazgp2vs43j-ovmf-20170116-1.13a50a6/share/firmware/ovmf_x64.bin
    -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time
    -m 4G
    -smp cpus=2
    -device virtio-balloon
    -rtc base=localtime,clock=host )

AUDIO_OPTIONS=( 
    -audiodev pa,id=snd0
    -device ich9-intel-hda
    -device hda-output,audiodev=snd0 )

NETWORK_OPTIONS=(
    -nic user,model=virtio-net-pci,hostfwd=tcp::5555-:5555,smb=/home/pooman123/andy_vm/windows/poop_smb,smbserver=10.0.2.4 )

GPU_OPTIONS=(
    -vga qxl )

DISK_OPTIONS=(
    -drive file=disk.qcow2,index=0,media=disk,if=virtio )

SPICE_OPTIONS=(
    -spice disable-ticketing=on,unix=on,addr=poo.sock
    -device virtio-serial
    -chardev spicevmc,id=spicechannel0,name=vdagent
    -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 )

qemu-system-x86_64 \
    "${GENERIC_OPTIONS[@]}" \
    "${AUDIO_OPTIONS[@]}" \
    "${NETWORK_OPTIONS[@]}" \
    "${GPU_OPTIONS[@]}" \
    "${DISK_OPTIONS[@]}" \
    "${SPICE_OPTIONS[@]}" \
    #-usb -device usb-tablet \
    #-drive file=/mnt/poo/stuff/isos/Win8.1_English_x64.iso,media=cdrom \
    #-drive file=/mnt/poo/stuff/isos/virtio-win-0.1.204.iso,media=cdrom
