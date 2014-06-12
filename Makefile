NASM=nasm

all:
	$(NASM) -f elf32 src/kernel.asm -o obj/bootstrap.o
	$(CC) -m32 -c src/kernel.c -o obj/kernel.o
