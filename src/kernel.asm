;; kernel.asm
bits 32
section .text
	; Multiboot
	align 4
	dd 0x1BADB002
	dd 0x00
	dd - (0x1BADB002 + 0x00)

global start

start:
	call main
	hlt

