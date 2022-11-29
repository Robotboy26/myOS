%define newline 0x0D, 0x0A
[org 0]   ; add 0 to label addresses
[bits 16]      ; tell the assembler we want 16 bit code

jmp enterProtectedMode

enterProtectedMode:
  cli
  lgdt {gdt_descriptor}

enableA20:
  in al, 0x92
  or al, 2
  out 0x92, al
  ret

times 2048 -($-$$) db 0