#!/usr/bin/env bash

GENERIC_OPTIONS=( 
    -nodefaults
    -enable-kvm
    -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time
    -m 8G
    -smp cpus=8
    -rtc base=localtime,clock=host
    -device virtio-balloon
    -device virtio-rng-pci )

AUDIO_OPTIONS=( 
    -audiodev pa,id=snd0
    -device ich9-intel-hda
    -device hda-output,audiodev=snd0 )

NETWORK_OPTIONS=(
    -nic user,model=virtio-net-pci )

GPU_OPTIONS=(
    -device virtio-vga-gl )

DISK_OPTIONS=(
    -drive file=disk.qcow2,index=0,media=disk,if=virtio
    -drive if=pflash,format=raw,readonly=on,file=$HOME/.guix-home/profile/share/firmware/ovmf_x64.bin
    -drive if=pflash,format=raw,file=./ovmf_vars_x64.bin )

SPICE_OPTIONS=(
    -spice disable-ticketing=on,unix=on,addr=poo.sock,gl=on
    
    #serial bus
    -device virtio-serial 
    
    #spice agent
    -chardev spicevmc,id=spicechannel0,name=vdagent
    -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0
    
    #qemu agent
    -chardev socket,path=/tmp/qga.sock,server=on,wait=off,id=qga0
    -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0

    #file sharing
    -chardev spiceport,name=org.spice-space.webdav.0,id=charchannel1
    -device virtserialport,chardev=charchannel1,id=channel1,name=org.spice-space.webdav.0 )


qemu-system-x86_64 \
    "${GENERIC_OPTIONS[@]}" \
    "${AUDIO_OPTIONS[@]}" \
    "${NETWORK_OPTIONS[@]}" \
    "${GPU_OPTIONS[@]}" \
    "${DISK_OPTIONS[@]}" \
    "${SPICE_OPTIONS[@]}" \
    #-drive file=/mnt/poo/stuff/isos/virtio-win-0.1.240.iso,media=cdrom \
    #-drive file=/mnt/poo/stuff/isos/en-us_windows_10_enterprise_ltsc_2021_x64_dvd_d289cf96.iso,media=cdrom    
