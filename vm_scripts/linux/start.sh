#!/bin/sh

GENERIC_OPTIONS=( 
    -nodefaults
    -enable-kvm
    -bios ~/.guix-home/profile/share/firmware/ovmf_x64.bin
    -cpu host
    -m 4G
    -smp cpus=2
    -device virtio-balloon )

AUDIO_OPTIONS=( 
    -audiodev pa,id=snd0
    -device ich9-intel-hda
    -device hda-output,audiodev=snd0 )

NETWORK_OPTIONS=(
    -nic user,model=virtio-net-pci,hostfwd=tcp::6666-:6666,hostfwd=tcp::8888-:22 )

GPU_OPTIONS=(
    -vga qxl )

DISK_OPTIONS=(
    -drive file=disk.qcow2,index=0,media=disk,if=virtio )

SPICE_OPTIONS=(
    -spice disable-ticketing=on,unix=on,addr=poo.sock
    -device virtio-serial
    -chardev spicevmc,id=spicechannel0,name=vdagent
    -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 
    -chardev socket,path=/tmp/qga.sock,server=on,wait=off,id=qga0
    -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 )

qemu-system-x86_64 \
    "${GENERIC_OPTIONS[@]}" \
    "${AUDIO_OPTIONS[@]}" \
    "${NETWORK_OPTIONS[@]}" \
    "${GPU_OPTIONS[@]}" \
    "${DISK_OPTIONS[@]}" \
    "${SPICE_OPTIONS[@]}"
    #-drive file=/asdf.iso,media=cdrom

