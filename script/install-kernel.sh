#!/bin/bash
TARGET=bin/disk.img
LOOP=/dev/loop0
MNT=mnt/
KERNEL=kernel-1
RELATIVEPATH=boot/
FULLPATH=$MNT$RELATIVEPATH$KERNEL

set -e

losetup $LOOP $TARGET
mount $LOOP $MNT
echo "Installing kernel in $FULLPATH"
cp bin/kernel $FULLPATH
echo "Done"
umount $MNT
losetup -d $LOOP
