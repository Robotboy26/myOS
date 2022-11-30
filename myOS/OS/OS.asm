%define newline 0x0D, 0x0A
[org 0]   ; add 0 to label addresses
[bits 16]      ; tell the assembler we want 16 bit code

jmp enterProtectedMode

%include "bootloaderThings/GDT.asm"
%include "bootloaderThings/stringStuff/printStr.asm"


enterProtectedMode:
  call enableA20
  cli
  lgdt [gdt_descriptor]
  mov eax, cr0
  or eax, 1
  mov cr0, eax
  jmp codeseg:startProtectedMode

enableA20:
  in al, 0x92
  or al, 2
  out 0x92, al
  ret

[bits 32]

startProtectedMode:

  mov ax, dataseg
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov [0xb8000], byte 'H'
  mov [0xb8002], byte 'E'
  mov [0xb8004], byte 'L'
  mov [0xb8006], byte 'L'
  mov [0xb8008], byte 'O'

  jmp $

times 2048 -($-$$) db 0