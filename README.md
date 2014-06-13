# What's this?

This is the start of a toy OS. It *really* doesn't do anything reasonable
right now. It's going to write a small message to the screen, and that's
it.

By the way, I'm calling it "Muppix". Mostly because it's sounds ridicoulus.
By default, Muppix is using grub2 as its boot loader, although any multiboot
setting should probably work fine. The multiboot part of the kernel is written
in assembler using **NASM** which then hands execution off to the rest of the
kernel, which is written in C.

There's no real goal with this. I was thinking I might learn a bit more about
the darker corners of an OS, as well as giving myself an excuse to look into
the POSIX standard, but that's far from now. Mostly, I'm just doing this
because it's fun. That's really it.

Muppix is released as open source under the MIT license. See LICENSE.txt for
more details.

## Layout

Quick layout of the repository:

		mnt/		Local mount point for OS image file
		script/		Contains a bunch of scripts, used by the makefile
				as well as a boot configuration template for grub.
				You shouldn't have to run any of these scripts
				manually
		src/		Source code

## Dependencies

### grub 2

You'll need to have grub 2 installed on the system you're working on. So far,
I've only built this kernel on **Debian 7.5**. The scripts expects to be able
to run **grub-install** on the image file that you'll boot from.

### nasm, linker and c compiler

In order to build the kernel, you'll need NASM and gcc (might work with other
C compilers as well. Haven't tried) as well as being able to link your objects using 
ld. You'll also need GNU make.

### Partitioning

You'll need to make sure that fdisk is installed as well since the scripts will
make use of it in order to partition the disk image.

### Booting the kernel

The simplest way so far seems to be to use **qemu**, but any VM should work (or, of 
course a real machine. But that's going to be boring to maintain while developing)

## Building

DISCLAIMER: The scripts are going to attach an image file to `/dev/loop0` and create
a new file system as well as partitions. The scripts *should* fail should something go 
wrong, but I can never guarantee this, so I just want to make the following absolutely clear:

**If something goes wrong and you screw your disk up, I am in no way responsible. There's
always a risk involved, and it's yours to take. Only do this if you know what you're doing
and are willing to accept that risk.**

### Preparing the disk image

Start by cloning the repository:

	git clone git@github.com:Lavesson/muppix.git

Next step, you'll need to prepare an image file. I've hacked together a handy script
and makefile target for this. Run the following with **root privilegies** from the
root folder of the repository:

	make img-gen

This will create a 20 MB image file and attach it to `/dev/loop0` (the script will fail
if something is already attached here). After attaching the image to the loop device,
the script will create a new file system (`ext2`) on it and mount it locally in the
repo folder (in `mnt/`). If everything has worked so far, **fdisk** should start. Setting
the partition up is *extremely* simple right now. Here's the console output:

		Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)

		Command (m for help): n
		Partition type:
		   p   primary (0 primary, 0 extended, 4 free)
		   e   extended
		Select (default p): 
		Using default response p
		Partition number (1-4, default 1): 
		Using default value 1
		First sector (2048-40959, default 2048): 
		Using default value 2048
		Last sector, +sectors or +size{K,M,G} (2048-40959, default 40959): 
		Using default value 40959

		Command (m for help): w
		The partition table has been altered!

		Syncing disks.
 
So basically, select `n` to create a new partition. Go with the default choices to set everything
up, and then issue `w` to write the partition tables to disk.

Time to install **grub2** to the image file. From the root of the repo, again with superuser/root
privilegies, type:

	make install-grub

You should get some output telling you that everything went fine. At this point, the image file
is ready and prepared. You shouldn't have to do this more than once.

### Building and installing the kernel

To build and install the kernel (installing it on the image file, nowhere else), simply type:

		make
		make install

The `make install` command needs root privilegies since it needs to access `losetup` and `mount`+`umount`
You should be able to find the image file in `bin/disk.img`. If you're using QEmu, you should be
able to just start Muppix by typing:

		qemu bin/disk.img

You should see a grub boot menu and be able to select the kernel from there. If you want to change the
kernel in some way, you should just have to redo the `make && make install` part above, as this will
build and deploy the kernel to the image file.
