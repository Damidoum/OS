.set MULTIBOOT_HEADER_MAGIC, 0x1BADB002
.set MULTIBOOT_HEADER_FLAGS, 0x00010003
.set STACK_SIZE, 0x4000

/* The multiboot header itself. It must come first. */
.section ".multiboot"
	/* Multiboot header must be aligned on a 4-byte boundary */
  .align 4
multiboot_header:
  .long MULTIBOOT_HEADER_MAGIC
  .long MULTIBOOT_HEADER_FLAGS
  .long -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)
  .long multiboot_header
  .long __b_kernel
  .long __e_load
  .long __e_kernel
  .long multiboot_entry

.section .text
.global _start
.extern kernelMain

_start:
  multiboot_entry: 
    movl $(stack + STACK_SIZE), %esp
    pushl %ebx /* function parameters */
    pushl %eax /* function parameters */
    call kernelMain

.section .bss
stack: 
  .space STACK_SIZE # size of the stack 
