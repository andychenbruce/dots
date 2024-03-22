#!/usr/bin/env bash

GENERIC_OPTIONS=( 
    -nodefaults
    -enable-kvm
    -cpu host
    -m 4G
    -smp cpus=2
    -device virtio-vga
    -device virtio-balloon-pci
    -device virtio-rng-pci )

NETWORK_OPTIONS=(
    -nic user,model=virtio-net-pci,hostfwd=tcp::6666-:6666,hostfwd=tcp::8888-:22 )

DISK_OPTIONS=(
    -drive file=disk.qcow2,index=0,media=disk,if=virtio
    -drive if=pflash,format=raw,readonly=on,file=$HOME/.guix-home/profile/share/firmware/ovmf_x64.bin
    -drive if=pflash,format=raw,file=./ovmf_vars_x64.bin )

qemu-system-x86_64 \
    "${GENERIC_OPTIONS[@]}" \
    "${NETWORK_OPTIONS[@]}" \
    "${DISK_OPTIONS[@]}"
