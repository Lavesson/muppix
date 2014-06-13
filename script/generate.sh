#!/bin/bash
OF=bin/disk.img
LOOP=/dev/loop0

# This function will just print the necessary info before
# throwing the user into fdisk
function usage {
	clear
	echo "# INFO"
	echo "# ----"
	echo "# fdisk is about to open - mostly because I *really*"
	echo "# don't like to script fdisk commands. The opened device"
	echo "# is the generated image (disk.img). Please setup one"
	echo "# primary partition and write the partition data"
	echo "#"
	echo "# When you're done, you can run 'make install-grub' to"
	echo "# place a grub installation on the image file"
	echo ""
}

# Make sure the script stops if something fails
set -e

# Create a zeroed-out 20 MB image:
dd if=/dev/zero of=$OF count=20 bs=1048576

# Connect the image to a loop device and prepare the
# filesystem as ext2. The script *SHOULD* fail if /dev/loop1 is already bound
losetup $LOOP $OF
mkfs.ext2 $LOOP
usage
fdisk $OF
losetup -d $LOOP
