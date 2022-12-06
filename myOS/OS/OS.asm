[bits 16]      ; tell the assembler we want 64 bit code

ret

times 2048 -($-$$) db 0 ; padding