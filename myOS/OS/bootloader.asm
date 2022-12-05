[bits 16]
[org 0x7c00]

KERNEL_OFFSET equ 0x1000 ; The same one we used when linking the kernel

mov [BOOT_DRIVE], dl ; Remember that the BIOS sets us the boot drive in 'dl' on boot
mov bp, 0x9000
mov sp, bp

call load_kernel ; read the kernel from disk
call switch_to_32bit ; disable interrupts, load GDT,  etc. Finally jumps to 'BEGIN_PM'
jmp $ ; Never executed

%include "bootloaderThings/disk.asm"
%include "bootloaderThings/gdt.asm"
%include "bootloaderThings/switch-to-32bit.asm"
%include "bootloaderThings/print-32bit.asm"
%include "bootloaderThings/cpuid.asm"
%include "bootloaderThings/SimplePageing.asm"



[bits 16]
load_kernel:
    mov bx, KERNEL_OFFSET ; Read from disk and store in 0x1000
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_32BIT:
    mov ebx, welcome
    call print32

    call DetectCPUID
    call DetectLongMode
    call SetUpIdentityPageing
    call EditGDT
    jmp CODE_SEG:Start64bit

    mov ebx, welcome2
    call print32

    jmp $

[bits 64]

Start64bit:
    mov edi, 0xb8000
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    rep stosq
    
    ;call KERNEL_OFFSET ; Give control to the kernel
    hlt
    ;jmp $ ; Stay here when the kernel returns control to us (if ever)

BOOT_DRIVE db 0 ; It is a good idea to store it in memory because 'dl' may get overwritten

welcome db "landed in 32bit real mode", 0
welcome2 db "detected cpuid and long mode and set up simple pageing", 0
welcome3 db "lol mate"




; padding
times 510 - ($-$$) db 0
dw 0xaa55