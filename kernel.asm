;; kernel.asm
bits 32
section .text

global start
extern kmain

start:
	cli
	call kmain
	hlt
