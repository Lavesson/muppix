NASM=nasm
LD=ld
OBJ=obj/
BIN=bin/

all: folders
	$(NASM) -f elf32 src/kernel.asm -o obj/bootstrap.o
	$(CC) -m32 -c src/kernel.c -o obj/kernel.o
	$(LD) -m elf_i386 -T src/link.ld -o bin/kernel obj/bootstrap.o obj/kernel.o

install:
	script/install-kernel.sh

install-grub:
	script/install-grub.sh

gen-img: folders
	script/generate.sh

folders:	
	mkdir -p $(OBJ)
	mkdir -p $(BIN)
