[bits 16]
[org 0x7c00]

KERNEL_OFFSET equ 0x1000 ; The same one we used when linking the kernel

mov [BOOT_DRIVE], dl ; Remember that the BIOS sets us the boot drive in 'dl' on boot
mov bp, 0x9000
mov sp, bp

call ReadDisk

mov ah, 0x0e
mov al, [PROGRAM_SPACE]
int 0x10
call switch_to_32bit ; disable interrupts, load GDT,  etc. Finally jumps to 'BEGIN_PM'
jmp $ ; Never executed

%include "bootloaderThings/disk.asm"
%include "bootloaderThings/gdt.asm"
%include "bootloaderThings/switch-to-32bit.asm"
%include "bootloaderThings/print-16bit.asm"
%include "bootloaderThings/print-32bit.asm"
%include "bootloaderThings/cpuid.asm"
%include "bootloaderThings/SimplePageing.asm"


[bits 32]
BEGIN_32BIT:
    call DetectCPUID
    call DetectLongMode
    call SetUpIdentityPageing
    call EditGDT
    jmp CODE_SEG:Start64bit

    jmp $

[bits 64]

Start64bit:
    mov edi, 0xb8000
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    rep stosq

    hlt
    ;jmp $ ; Stay here when the kernel returns control to us (if ever)

BOOT_DRIVE db 0 ; It is a good idea to store it in memory because 'dl' may get overwritten



; padding
times 510 - ($-$$) db 0
dw 0xaa55