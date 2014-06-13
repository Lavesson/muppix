#!/bin/bash
OF=bin/disk.img
LOOP=/dev/loop0
MNT=mnt/
CFGSOURCE=script/grub.cfg
CFGDEST=boot/grub/grub.cfg
CFGMOUNTDEST=$MNT$CFGDEST

# Acquire loop device and mount it
losetup $LOOP $OF
mount $LOOP $MNT

# Install grub to loop
grub-install 	--no-floppy \
		--modules="biosdisk part_msdos ext2 configfile normal multiboot" \
		--root-directory=$MNT \
		--force $LOOP

# Copy the boot configuration
cp $CFGSOURCE $CFGMOUNTDEST

# ... aaaand, unmount and release the loop
umount $MNT
losetup -d $LOOP

