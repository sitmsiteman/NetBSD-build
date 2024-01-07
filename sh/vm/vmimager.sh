#!/bin/sh

. ./env.sh

# Create a disk image.
gunzip -c "$OBJ/releasedir/$ARCH_MACHINE/binary/gzimg/arm64.img.gz" > "$WORKSPACE/vm/disk.img"

# Make it a sparse 10 GB image.
dd if=/dev/zero of=$VM/disk.img seek=10G bs=1 count=1

# Make a symlink to the kernel.
ln -sfn "$KERNDIR/$KERN_IMG" "$VM"
