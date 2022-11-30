%define newline 0x0D, 0x0A
[org 0x07e0]   ; add 0 to label addresses
[bits 32]      ; tell the assembler we want 16 bit code

  ret

times 2048 -($-$$) db 0