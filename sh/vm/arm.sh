#!/bin/sh

. ./env.sh

qemu-system-aarch64 \
	-kernel "$KERN_IMG" \
	-append "root=dk1" \
	-M virt \
	-cpu cortex-a53 \
	-smp 2 \
	-m 1g \
	-drive if=none,file=disk.img,id=disk,format=raw \
	-device virtio-blk-device,drive=disk \
	-device virtio-rng-device \
	-nic user,model=virtio-net-pci \
	-nographic
