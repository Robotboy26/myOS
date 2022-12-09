[bits 16]
[org 0x7c00]

mov [BOOT_DRIVE], dl ; Remember that the BIOS sets us the boot drive in 'dl' on boot
mov bp, 0x9000
mov sp, bp

call ReadDisk
mov bx, hello
call print16

jmp PROGRAM_SPACE
jmp $ ; Never executed

%include "bootloaderThings/disk.asm"
%include "bootloaderThings/print-16bit.asm"

BOOT_DRIVE db 0 ; It is a good idea to store it in memory because 'dl' may get overwritten
hello db 'HEeeeLLo world'



; padding
times 510 - ($-$$) db 0
dw 0xaa55