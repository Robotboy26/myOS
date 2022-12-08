[org 0x7e00]
[bits 16]      ; tell the assembler we want 64 bit code

mov bx, welcome
call print16

jmp $

%include "bootloaderThings/disk.asm"
%include "bootloaderThings/gdt.asm"
%include "bootloaderThings/print-16bit.asm"
%include "bootloaderThings/print-32bit.asm"
%include "bootloaderThings/cpuid.asm"
%include "bootloaderThings/SimplePageing.asm"

EnterProtectedMode:
    cli ; 1. disable interrupts
    lgdt [gdt_descriptor] ; 2. load the GDT descriptor
    mov eax, cr0
    or eax, 1 ; 3. set 32-bit mode bit in cr0
    mov cr0, eax
    jmp CODE_SEG:StartProtectedMode

EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

StartProtectedMode:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov [0xb8000], byte 'H'
    mov [0xb8002], byte 'e'
    mov [0xb8004], byte 'l'
    mov [0xb8006], byte 'l'
    mov [0xb8008], byte 'o'


welcome db 'welcome'
times 2048 -($-$$) db 0 ; padding