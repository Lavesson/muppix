;; kernel.asm
bits 32

global start

; 'main' is just an awesome name for a main function:
extern main

; Given the fact that I'm a lazy bastard, the following section exists.
; It's simply here to setup everything needed to conform to the
; multiboot spec (grub requires this). Check the grub docs for more
; info on this.
MODULEALIGN equ  1<<0 
MEMINFO     equ  1<<1
FLAGS       equ  MODULEALIGN | MEMINFO
MAGIC       equ  0x1BADB002
CHECKSUM    equ -(MAGIC + FLAGS)

section .text
align 4
MultiBootHeader:
   dd MAGIC
   dd FLAGS
   dd CHECKSUM

; The actual entry point 
start:
	call main
	hlt

